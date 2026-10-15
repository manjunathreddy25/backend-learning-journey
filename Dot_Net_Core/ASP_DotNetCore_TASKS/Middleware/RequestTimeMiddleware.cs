using ASP_DotNetCore_TASKS.Exceptions;
using System.Diagnostics;

namespace ASP_DotNetCore_TASKS.Middleware
{
    public class RequestTimeMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<RequestTimeMiddleware> _logger;

        public RequestTimeMiddleware(
            RequestDelegate next,
            ILogger<RequestTimeMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            var stopwatch = Stopwatch.StartNew();

            Console.WriteLine("1. BEFORE _next");

            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An exception occurred.");

                if (ex is NotFoundException)
                {
                    await HandleExceptionAsync(context, ex);
                }
                else
                {
                    throw;
                }
            }
            finally
            {
                stopwatch.Stop();

                _logger.LogInformation(
                    "Request {method} {path} took {time} ms",
                    context.Request.Method,
                    context.Request.Path,
                    stopwatch.ElapsedMilliseconds
                );
            }
            Console.WriteLine("1. AFTER _next");
        }

        private static async Task HandleExceptionAsync(HttpContext context,Exception exception)
        {
            if (context.Response.HasStarted)
            {
                throw new InvalidOperationException(
                    "The response has already started.");
            }

            context.Response.StatusCode = StatusCodes.Status404NotFound;
            context.Response.ContentType = "application/json";

            var response = new
            {
                statusCode = StatusCodes.Status404NotFound,
                message = exception.Message
            };

            await context.Response.WriteAsJsonAsync(response);
        }
    }
}