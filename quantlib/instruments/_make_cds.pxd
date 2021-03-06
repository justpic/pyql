from quantlib.types cimport Real, Natural
from libcpp cimport bool
from quantlib.handle cimport shared_ptr, Handle
from quantlib.pricingengines._pricing_engine cimport PricingEngine
from quantlib.time._calendar cimport Calendar
from quantlib.time._daycounter cimport DayCounter
from quantlib.time._date cimport Date
from quantlib.time._period cimport Period
from quantlib.time._schedule cimport Rule
from ._credit_default_swap cimport Side, CreditDefaultSwap

cdef extern from 'ql/instruments/makecds.hpp' namespace 'QuantLib':
    """
    namespace QuantLib{
    static inline ext::shared_ptr<CreditDefaultSwap> cast(MakeCreditDefaultSwap& cds) { return (ext::shared_ptr<CreditDefaultSwap>)(cds);};
    }
    """
    cdef cppclass MakeCreditDefaultSwap:
        MakeCreditDefaultSwap(const Period& Tenor, Real couponRate)
        MakeCreditDefaultSwap(const Date& termDate, Real couponRate)

        CreditDefaultSwap operator() const
        shared_ptr[CreditDefaultSwap] operator() const

        MakeCreditDefaultSwap& withUpfrontRate(Real)
        MakeCreditDefaultSwap& withSide(Side)
        MakeCreditDefaultSwap& withNominal(Real)
        MakeCreditDefaultSwap& withCouponTenor(Period)
        MakeCreditDefaultSwap& withDayCounter(DayCounter&)
        MakeCreditDefaultSwap& withLastPeriodDayCounter(DayCounter&)
        MakeCreditDefaultSwap& withDateGenerationRule(Rule rule)
        MakeCreditDefaultSwap& withCashSettlementDays(Natural cashSettlementDays)

        MakeCreditDefaultSwap& withPricingEngine(const shared_ptr[PricingEngine]&)
    shared_ptr[CreditDefaultSwap] cast(MakeCreditDefaultSwap&) except +
