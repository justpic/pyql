from cython.operator cimport dereference as deref

from quantlib cimport ql
from quantlib.ql cimport shared_ptr

from quantlib.time.calendar cimport Calendar
from quantlib.time.date cimport Date
from quantlib.time.daycounter cimport DayCounter

cdef class BlackVolTermStructure:

    def __cinit__(self):
        self._thisptr = NULL

    def __dealloc__(self):
        if self._thisptr is not NULL:
            del self._thisptr

    def __init__(self):
        raise ValueError(
            'BlackVolTermStructure cannot be directly instantiated!'
        )


cdef class BlackConstantVol(BlackVolTermStructure):

    def __init__(self,
        Date reference_date,
        Calendar calendar,
        float volatility,
        DayCounter daycounter
    ):

        self._thisptr = new shared_ptr[ql.BlackVolTermStructure](
            new ql.BlackConstantVol(
                deref(reference_date._thisptr.get()),
                deref(calendar._thisptr),
                volatility,
                deref(daycounter._thisptr)
            )
        )

