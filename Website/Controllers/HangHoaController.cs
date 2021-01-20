using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Website.Data;
using Website.ViewModels;

namespace Website.Controllers
{
    public class HangHoaController : Controller
    {
        private readonly MyDbContext _context;

        public HangHoaController(MyDbContext ctx)
        {
            _context = ctx;
        }

        public IActionResult Index(int? MaLoai)
        {
            
            var data = _context.HangHoas.AsQueryable();
            if(MaLoai.HasValue)
            {
                ViewBag.DanhMuc = _context.Loais.FirstOrDefault(lo => lo.MaLoai == MaLoai.Value).TenLoai;

                data = data.Where(hh => hh.MaLoai == MaLoai || hh.Loai.MaLoaiCha == MaLoai);

                //C2
                //List<int> dsLoai = LayDanhSachLoai(MaLoai);
                //data = data.Where(hh => dsLoai.Contains(hh.MaLoai.Value));
            }
           
            var dsHangHoa = data.Select(hh => new HangHoaVM
            {
                MaHh = hh.MaHangHoa,
                TenHh = hh.TenHh,
                DonGia = hh.DonGia,
                GiamGia = hh.GiamGia,
                Hinh = hh.Hinh,
                MoTa = hh.MoTa,
                SoLuong = hh.SoLuong,
                TenLoai = hh.Loai.TenLoai
            }).ToList();
            return View(dsHangHoa);
        }

        private List<int> LayDanhSachLoai(int? maLoai)
        {
            var danhSach = new List<int>();


            return danhSach;
        }

        private void DeQuyTimLoai(int maLoai, List<int> danhSach)
        {
            danhSach.Add(maLoai);
            var loaiCon = _context.Loais
                .Where(lo => lo.MaLoaiCha == maLoai)
                .Select(lo => lo.MaLoai).ToList();
            while(loaiCon.Any())
            {
                var loaiConCanTim = loaiCon.First();
                loaiCon.Remove(loaiConCanTim);

                DeQuyTimLoai(loaiConCanTim, danhSach);
            }
        }

        public IActionResult Detail(Guid id)
        {
            var hh = _context.HangHoas
                .Include(hh => hh.Loai)
                .FirstOrDefault(hh => hh.MaHangHoa == id);
            if(hh == null)
            {
                return Redirect("/Home/PageNotFound");
            }
            var ds1 = _context.HangHoas.Where(d => d.MaLoai == 1).Take(8).ToList();
            ViewBag.ds1 = ds1;
            return View(hh);
        }
        public async Task<IActionResult> TimKiem(string searchString)
        {
            if (!String.IsNullOrEmpty(searchString))
            {
                return View(await _context.HangHoas.Where(p => p.TenHh.Contains(searchString)).ToListAsync());
            }
            else
            {
                return View(await _context.HangHoas.Skip(6).Take(6).ToListAsync());
            }
        }
    }
}