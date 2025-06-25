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

(declare-sort var2799 0)
(declare-sort var458 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2799-to-String (var2799) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var458_intCast/-1897602882 (Int) Int)
(declare-fun var458_count/-968518540 (var2799) Int)
(declare-fun cast-from-__Array__Int__String__-to-var2799 ((Array Int String)) var2799)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2799 var2799)
(declare-const var2628 var2799) ; Statement: r4 := @parameter0: java.lang.Object 
(assert (not (= var2628 null-var2799)))
(declare-const var1516 var2799) ; Statement: r5 := @parameter1: java.lang.Object 
(assert (not (= var1516 null-var2799)))
(define-const var2876 String (cast-from-var2799-to-String var1516)) ; Statement: $r1 = (java.lang.String) r5 
(define-const var3622 String (cast-from-String-to-String "\n")) ; Statement: $r0 = (java.lang.String) "\n" 
(define-const var1665 Int (var458_intCast/-1897602882 -1)) ; Statement: $i0 = staticinvoke <clojure.lang.RT: int intCast(long)>(-1L) 
; split operation: var1656 = var2876.split(var3622, var1665) ; Statement: r6 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r0, $i0) 
(define-const var3006 Int (var458_count/-968518540 (cast-from-__Array__Int__String__-to-var2799 var1656))) ; Statement: $i1 = staticinvoke <clojure.lang.RT: int count(java.lang.Object)>(r6) 
(define-const var1983 Int (cast-from-Int-to-Int var3006)) ; Statement: $l2 = (long) $i1 
(define-const var1224 Int (ite (> var1983 1) 1 (ite (< var1983 1) -1 0))) ; Statement: $b3 = $l2 cmp 1L 
 ; Statement: if $b3 != 0 goto $r2 = new clojure.pprint$write_initial_lines$fn__10335 
(assert (not (not (= var1224 0)))) ; Negate: Cond: $b3 != 0  
(define-const var3726 var2799 var1516) ; Statement: $r7 = r5 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {cast-from-var2799-to-String=([java.lang.Object], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.String), var458_intCast/-1897602882=([long], int), var458_count/-968518540=([java.lang.Object], int), cast-from-__Array__Int__String__-to-var2799=([java.lang.String[]], java.lang.Object), cast-from-Int-to-Int=([int], long)}
; {var2799=java.lang.Object, var2628=r4, var1516=r5, var2876=$r1, var3622=$r0, var458=clojure.lang.RT, var1665=$i0, var1656=r6, var3006=$i1, var1983=$l2, var1224=$b3, var3726=$r7}
; {java.lang.Object=var2799, r4=var2628, r5=var1516, $r1=var2876, $r0=var3622, clojure.lang.RT=var458, $i0=var1665, r6=var1656, $i1=var3006, $l2=var1983, $b3=var1224, $r7=var3726}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.lang.Object;	r5 := @parameter1: java.lang.Object;	$r1 = (java.lang.String) r5;	$r0 = (java.lang.String) "\n";	$i0 = staticinvoke <clojure.lang.RT: int intCast(long)>(-1L);	r6 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r0, $i0);	$i1 = staticinvoke <clojure.lang.RT: int count(java.lang.Object)>(r6);	$l2 = (long) $i1;	$b3 = $l2 cmp 1L;	if $b3 != 0 goto $r2 = new clojure.pprint$write_initial_lines$fn__10335;	$r7 = r5;	goto [?= return $r7];	return $r7
;block_num 3