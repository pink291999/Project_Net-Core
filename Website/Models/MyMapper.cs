using AutoMapper;
using Website.Data;
using Website.ViewModels;

namespace Website.Models
{
    public class MyMapper : Profile
    {
        public MyMapper()
        {
            CreateMap<HangHoa, CartItem>();
            CreateMap<RegisterVM, KhachHang>();
        }
    }
}
