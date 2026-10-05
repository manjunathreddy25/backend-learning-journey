using ASP_DotNetCore_TASKS.Exceptions;
using System.Diagnostics;
using System.Net;

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
                _logger.LogError(
                    ex,
                    "An unexpected error occurred.");

                await HandleExceptionAsync(context, ex);
            }

            Console.WriteLine("1. AFTER _next");

            stopwatch.Stop();

            _logger.LogInformation(
                "Request {method} {path} took {time} ms",
                context.Request.Method,
                context.Request.Path,
                stopwatch.ElapsedMilliseconds
            );
        }

        private static async Task HandleExceptionAsync(
            HttpContext context,
            Exception exception)
        {
            if (context.Response.HasStarted)
            {
                throw exception;
            }
            int statusCode;
            string message;
            if (exception is NotFoundException)
            {
                statusCode = 404;
                message = exception.Message;
            }
            else
            {
                statusCode = 500;
                message = "An unexpected error occurred.";
            }

            context.Response.StatusCode = statusCode;
            context.Response.ContentType = "application/json";

            var response = new
            {
                statusCode = statusCode,
                message = message
            };

            await context.Response.WriteAsJsonAsync(response);
        }
    }
}