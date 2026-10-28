using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SchoolAppCoreRazor.Data;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages_Enrollments
{
    public class IndexModel : PageModel
    {
        private readonly SchoolAppCoreRazor.Data.SchoolContext _context;

        public IndexModel(SchoolAppCoreRazor.Data.SchoolContext context)
        {
            _context = context;
        }

        public IList<Enrollment> Enrollment { get;set; } = default!;

        public async Task OnGetAsync()
        {
            Enrollment = await _context.Enrollments
                .Include(e => e.Course)
                .Include(e => e.Student).ToListAsync();
        }
    }
}
