using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Website.Data;
using System.Threading.Tasks;

namespace Website.ViewComponents
{
    public class CategoryMenu : ViewComponent
    {
        private readonly MyDbContext _context;

        public CategoryMenu(MyDbContext ctx)
        {
            _context = ctx;
        }

        public async Task<IViewComponentResult> InvokeAsync() {
            return View(await _context.Loais.ToListAsync());
        }
    }
}
