import clingo
import sys

def run(instance):
    ctl = clingo.Control()
    m = set() 
    def on_model(model):
        m.update(model.symbols(atoms=True))
    ctl.configuration.solve.models="0"
    ctl.load("../date-lib.lp")
    ctl.load(instance)

    ctl.ground([("base",[])])
    ctl.solve(on_model=on_model)
    return m

def test_date_consider_month():
    answer = set(run("date_consider_month_2020.lp"))
    assert({clingo.parse_term("date_consider((31,1,2020))")} <= answer)
    assert({clingo.parse_term("date_consider((28,2,2020))")} <= answer)
    assert({clingo.parse_term("date_consider((29,2,2020))")} <= answer)
    assert(clingo.parse_term("date_consider((30,2,2020))") not in answer)
    assert({clingo.parse_term("date_consider((30,4,2020))")} <= answer)
    assert(clingo.parse_term("date_consider((31,4,2020))") not in answer)

    answer = set(run("date_consider_month_2021.lp"))
    assert({clingo.parse_term("date_consider((31,1,2021))")} <= answer)
    assert({clingo.parse_term("date_consider((28,2,2021))")} <= answer)
    assert(clingo.parse_term("date_consider((29,2,2021))") not in answer)
    assert(clingo.parse_term("date_consider((30,2,2021))") not in answer)
    assert(clingo.parse_term("date_consider((31,4,2021))") not in answer)

    answer = set(run("date_consider_month_2004.lp"))
    assert({clingo.parse_term("date_consider((31,1,2004))")} <= answer)
    assert({clingo.parse_term("date_consider((28,2,2004))")} <= answer)
    assert({clingo.parse_term("date_consider((29,2,2004))")} <= answer)
    assert(clingo.parse_term("date_consider((30,2,2004))") not in answer)
    assert({clingo.parse_term("date_consider((30,4,2004))")} <= answer)
    assert(clingo.parse_term("date_consider((31,4,2004))") not in answer)

def test_is_leap_year():
    answer = set(run("date_consider_month_2020.lp"))
    assert({clingo.parse_term("is_leap_year(2020)")} <= answer)
    
    answer = set(run("date_consider_month_2021.lp"))
    assert(clingo.parse_term("is_leap_year(2021)") not in answer)

    answer = set(run("date_consider_month_2004.lp"))
    assert({clingo.parse_term("is_leap_year(2004)")} <= answer)
