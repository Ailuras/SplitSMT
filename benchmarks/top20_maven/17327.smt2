(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1584 0)
(declare-sort var1573 0)
(declare-sort var66 0)
(declare-sort var1794 0)
(declare-sort var2667 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1584-to-String (var1584) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1573_intCast/-1897602882 (Int) Int)
(declare-fun var1573_count/-968518540 (var1584) Int)
(declare-fun cast-from-__Array__Int__String__-to-var1584 ((Array Int String)) var1584)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var66-init () var66)
(declare-fun <init>/529794308 (var66 var1584 var1584) void)
(declare-fun cast-from-var66-to-var1794 (var66) var1794)
(declare-fun var2667_runInTransaction/1409281936 (var1794) var1584)
(declare-const null-var1584 var1584)
(declare-const var3300 var1584) ; Statement: r4 := @parameter0: java.lang.Object 
(assert (not (= var3300 null-var1584)))
(declare-const var1858 var1584) ; Statement: r5 := @parameter1: java.lang.Object 
(assert (not (= var1858 null-var1584)))
(define-const var589 String (cast-from-var1584-to-String var1858)) ; Statement: $r1 = (java.lang.String) r5 
(define-const var2733 String (cast-from-String-to-String "\n")) ; Statement: $r0 = (java.lang.String) "\n" 
(define-const var1204 Int (var1573_intCast/-1897602882 -1)) ; Statement: $i0 = staticinvoke <clojure.lang.RT: int intCast(long)>(-1L) 
; split operation: var201 = var589.split(var2733, var1204) ; Statement: r6 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r0, $i0) 
(define-const var2163 Int (var1573_count/-968518540 (cast-from-__Array__Int__String__-to-var1584 var201))) ; Statement: $i1 = staticinvoke <clojure.lang.RT: int count(java.lang.Object)>(r6) 
(define-const var3307 Int (cast-from-Int-to-Int var2163)) ; Statement: $l2 = (long) $i1 
(define-const var2894 Int (ite (> var3307 1) 1 (ite (< var3307 1) -1 0))) ; Statement: $b3 = $l2 cmp 1L 
 ; Statement: if $b3 != 0 goto $r2 = new clojure.pprint$write_initial_lines$fn__10335 
(assert (not (= var2894 0))) ; Cond: $b3 != 0 
(define-const var1031 var66 var66-init) ; Statement: $r2 = new clojure.pprint$write_initial_lines$fn__10335 
(assert true)
;(assert (<init>/529794308 var1031 (cast-from-__Array__Int__String__-to-var1584 var201) var3300)) ; Statement: specialinvoke $r2.<clojure.pprint$write_initial_lines$fn__10335: void <init>(java.lang.Object,java.lang.Object)>(r6, r4) 

(declare-const var1031!1 var66)
(declare-const var201!1 (Array Int String))
(declare-const var3300!1 var1584)
(define-const var3737 var1794 (cast-from-var66-to-var1794 var1031!1)) ; Statement: $r3 = (java.util.concurrent.Callable) $r2 
(define-const var3379 var1584 (var2667_runInTransaction/1409281936 var3737)) ; Statement: $r7 = staticinvoke <clojure.lang.LockingTransaction: java.lang.Object runInTransaction(java.util.concurrent.Callable)>($r3) 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {cast-from-var1584-to-String=([java.lang.Object], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.String), var1573_intCast/-1897602882=([long], int), var1573_count/-968518540=([java.lang.Object], int), cast-from-__Array__Int__String__-to-var1584=([java.lang.String[]], java.lang.Object), cast-from-Int-to-Int=([int], long), var66-init=([], clojure.pprint$write_initial_lines$fn__10335), <init>/529794308=([clojure.pprint$write_initial_lines$fn__10335, java.lang.Object, java.lang.Object], void), cast-from-var66-to-var1794=([clojure.pprint$write_initial_lines$fn__10335], java.util.concurrent.Callable), var2667_runInTransaction/1409281936=([java.util.concurrent.Callable], java.lang.Object)}
; {var1584=java.lang.Object, var3300=r4, var1858=r5, var589=$r1, var2733=$r0, var1573=clojure.lang.RT, var1204=$i0, var201=r6, var2163=$i1, var3307=$l2, var2894=$b3, var66=clojure.pprint$write_initial_lines$fn__10335, var1031=$r2, var1794=java.util.concurrent.Callable, var3737=$r3, var2667=clojure.lang.LockingTransaction, var3379=$r7}
; {java.lang.Object=var1584, r4=var3300, r5=var1858, $r1=var589, $r0=var2733, clojure.lang.RT=var1573, $i0=var1204, r6=var201, $i1=var2163, $l2=var3307, $b3=var2894, clojure.pprint$write_initial_lines$fn__10335=var66, $r2=var1031, java.util.concurrent.Callable=var1794, $r3=var3737, clojure.lang.LockingTransaction=var2667, $r7=var3379}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.lang.Object;	r5 := @parameter1: java.lang.Object;	$r1 = (java.lang.String) r5;	$r0 = (java.lang.String) "\n";	$i0 = staticinvoke <clojure.lang.RT: int intCast(long)>(-1L);	r6 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r0, $i0);	$i1 = staticinvoke <clojure.lang.RT: int count(java.lang.Object)>(r6);	$l2 = (long) $i1;	$b3 = $l2 cmp 1L;	if $b3 != 0 goto $r2 = new clojure.pprint$write_initial_lines$fn__10335;	$r2 = new clojure.pprint$write_initial_lines$fn__10335;	specialinvoke $r2.<clojure.pprint$write_initial_lines$fn__10335: void <init>(java.lang.Object,java.lang.Object)>(r6, r4);	$r3 = (java.util.concurrent.Callable) $r2;	$r7 = staticinvoke <clojure.lang.LockingTransaction: java.lang.Object runInTransaction(java.util.concurrent.Callable)>($r3);	return $r7
;block_num 3