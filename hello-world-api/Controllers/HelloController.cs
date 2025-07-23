using Microsoft.AspNetCore.Mvc;

namespace hello_world_api.Controllers
{
    [ApiController]
    [Route("/")] 
    public class HelloController : ControllerBase
    {
        [HttpGet]
        public string Get()
        {
            return "Hello world!!!!!!";
        }
    }
}

