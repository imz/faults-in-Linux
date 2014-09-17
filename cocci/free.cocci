// use argument -D fn=xxx for the name of the freeing function of interest

@free@
identifier virtual.fn;
expression E;
position p1;
@@

fn@p1(E,...)

@print expression@
constant char *c;
expression free.E,E2;
type T;
position p;
identifier f;
@@

(
 f(...,c,...,(T)E@p,...)
|
 E@p == E2
|
 E@p != E2
|
 !E@p
|
 E@p || ...
)

@sz@
expression free.E;
position p;
@@

 sizeof(<+...E@p...+>)

@loop exists@
expression E;
identifier l;
position ok;
identifier virtual.fn;
@@

while (1) { ...
  fn@ok(E,...)
  ... when != break;
      when != goto l;
      when forall
}

@r exists@
expression free.E, subE<=free.E, E2;
expression E1;
iterator iter;
statement S;
position free.p1!=loop.ok,p2!={print.p,sz.p};
identifier virtual.fn;
@@

fn@p1(E,...)
...
(
 iter(...,subE,...) S // no use
|
 list_remove_head(E1,subE,...)
|
 subE = E2
|
 subE++
|
 ++subE
|
 --subE
|
 subE--
|
 &subE
|
 BUG(...)
|
 BUG_ON(...)
|
 return_VALUE(...)
|
 return_ACPI_STATUS(...)
|
 E@p2 // bad use
)

@script:python@
p1 << free.p1;
p2 << r.p2;
@@

cocci.print_main("kfree",p1)
cocci.print_secs("ref",p2)
