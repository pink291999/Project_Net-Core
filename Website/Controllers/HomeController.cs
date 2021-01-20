using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Website.Data;

namespace Website.Controllers
{
    public class HomeController : Controller
    {
        private readonly MyDbContext _context;

        public HomeController(MyDbContext ctx)
        {
            _context = ctx;
        }
        public IActionResult Index()
        {
            var ds1 = _context.HangHoas.OrderBy(d => d.DonGia).Take(5).ToList();
            ViewBag.ds1 = ds1;
            var ds2 = _context.HangHoas.Where(d => d.GiamGia>0).Take(5).ToList();
            ViewBag.ds2 = ds2;
            return View();
        }
        public IActionResult Contact()
        {
            return View();
        }
        public IActionResult Nintendo()
        {
            return View( _context.HangHoas.Where(p => p.MaLoai==1).ToList());
        }
        public IActionResult Sony()
        {
            return View(_context.HangHoas.Where(p => p.MaLoai == 2).ToList());
        }
        public IActionResult Games()
        {
            return View(_context.HangHoas.Where(p => p.MaLoai == 3).ToList());
        }
        public IActionResult News()
        {
            return View();
        }
        public IActionResult News1()
        {
            return View();
        }
        public IActionResult News2()
        {
            return View();
        }
        public IActionResult News3()
        {
            return View();
        }
    }
}
