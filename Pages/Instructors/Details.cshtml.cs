using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SchoolAppCoreRazor.Data;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages_Instructors
{
    public class DetailsModel : PageModel
    {
        private readonly SchoolAppCoreRazor.Data.SchoolContext _context;

        public DetailsModel(SchoolAppCoreRazor.Data.SchoolContext context)
        {
            _context = context;
        }

        public Instructor Instructor { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var instructor = await _context.Instructors.FirstOrDefaultAsync(m => m.InstructorId == id);

            if (instructor is not null)
            {
                Instructor = instructor;

                return Page();
            }

            return NotFound();
        }
    }
}
