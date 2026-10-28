using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SchoolAppCoreRazor.Data;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages_Courses
{
    public class DetailsModel : PageModel
    {
        private readonly SchoolAppCoreRazor.Data.SchoolContext _context;

        public DetailsModel(SchoolAppCoreRazor.Data.SchoolContext context)
        {
            _context = context;
        }

        public Course Course { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var course = await _context.Courses.FirstOrDefaultAsync(m => m.CourseId == id);

            if (course is not null)
            {
                Course = course;

                return Page();
            }

            return NotFound();
        }
    }
}
