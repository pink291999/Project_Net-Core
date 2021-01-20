using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Website.Data;
using Website.Helpers;
using Website.ViewModels;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;

namespace Website.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize]
    public class HangHoaController : Controller
    {
        private readonly ILogger _logger;
        private readonly MyDbContext _context;

        public HangHoaController(MyDbContext ctx, ILogger<HangHoaController> logger)
        {
            _context = ctx;
            _logger = logger;
        }

        public async Task<IActionResult> Index()
        {
            var data = await _context.HangHoas
                .Include(hh => hh.Loai)
                .ToListAsync();
            return View(data);
        }

        public IActionResult Create()
        {
            ViewBag.DanhSachLoai = new LoaiDropDownVM(_context.Loais, "MaLoai", "TenLoai", "MaLoai");
            return View();
        }

        [HttpPost]
        public IActionResult Create(HangHoa hh, IFormFile Hinh, IFormFile Hinh2, IFormFile Hinh3, IFormFile Hinh4, IFormFile Hinh5)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var urlHinh = FileHelper.UploadFileToFolder(Hinh, "HangHoa");
                    hh.Hinh = urlHinh;
                    var urlHinh2 = FileHelper.UploadFileToFolder(Hinh2, "HangHoa");
                    hh.Hinh2 = urlHinh2;
                    var urlHinh3 = FileHelper.UploadFileToFolder(Hinh3, "HangHoa");
                    hh.Hinh3 = urlHinh3;
                    var urlHinh4 = FileHelper.UploadFileToFolder(Hinh4, "HangHoa");
                    hh.Hinh4 = urlHinh4;
                    var urlHinh5 = FileHelper.UploadFileToFolder(Hinh5, "HangHoa");
                    hh.Hinh5 = urlHinh5;
                    _context.Add(hh);
                    _context.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, $"Loi: {ex.Message}");

                    ViewBag.ThongBaoLoi = "Có lỗi";
                    ViewBag.DanhSachLoai = new LoaiDropDownVM(_context.Loais, "MaLoai", "TenLoai", "MaLoai");
                    return View();
                }
            }

            ViewBag.DanhSachLoai = new LoaiDropDownVM(_context.Loais, "MaLoai", "TenLoai", "MaLoai");
            return View();
        }

        public IActionResult Edit(Guid id)
        {
            var hh = _context.HangHoas.FirstOrDefault(h => h.MaHangHoa == id);

            ViewBag.DanhSachLoai = new LoaiDropDownVM(_context.Loais, "MaLoai", "TenLoai", "MaLoai", hh.MaLoai);
            return View(hh);
        }
    }
}