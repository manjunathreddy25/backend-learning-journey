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
            await _next(context);
            Console.WriteLine("1. AFTER _next");

            stopwatch.Stop();

            _logger.LogInformation(
                "Request {method} {path} took {time} ms",
                context.Request.Method,
                context.Request.Path,
                stopwatch.ElapsedMilliseconds
            );
        }
    }
}