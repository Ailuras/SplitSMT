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

(declare-sort var832 0)
(declare-sort var1374 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var832-to-String (var832) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1374_invokeStatic/-942663584 (var832) var832)
(declare-fun cast-from-__Array__Int__String__-to-var832 ((Array Int String)) var832)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var832 var832)
(declare-const var2363 var832) ; Statement: r12 := @parameter0: java.lang.Object 
(assert (not (= var2363 null-var832)))
(define-const var985 String (cast-from-var832-to-String var2363)) ; Statement: $r1 = (java.lang.String) r12 
(define-const var1961 String (cast-from-String-to-String "\n")) ; Statement: $r0 = (java.lang.String) "\n" 
; split operation: var1966 = var985.split(var1961) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>($r0) 
(define-const var1119 var832 (var1374_invokeStatic/-942663584 (cast-from-__Array__Int__String__-to-var832 var1966))) ; Statement: r13 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>($r2) 
(define-const var2665 var832 null-var832) ; Statement: r14 = null 
(define-const var465 Int 0) ; Statement: l4 = 0L 
(define-const var3028 Int 0) ; Statement: l5 = 0L 
(assert true) ; Non Conditional
(define-const var2866 Int (ite (> var3028 var465) 1 (ite (< var3028 var465) -1 0))) ; Statement: $b6 = l5 cmp l4 
(define-const var1125 Int (cast-from-Int-to-Int var2866)) ; Statement: $i7 = (int) $b6 
 ; Statement: if $i7 >= 0 goto r16 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>(r13) 
(assert (>= var1125 0)) ; Cond: $i7 >= 0 
(define-const var265 var832 (var1374_invokeStatic/-942663584 var1119)) ; Statement: r16 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>(r13) 
 ; Statement: if r16 == null goto return null 
(assert (= var265 null-var832)) ; Cond: r16 == null 
 ; Statement: return null 
(check-sat)
; {cast-from-var832-to-String=([java.lang.Object], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.String), var1374_invokeStatic/-942663584=([java.lang.Object], java.lang.Object), cast-from-__Array__Int__String__-to-var832=([java.lang.String[]], java.lang.Object), cast-from-Int-to-Int=([byte], int)}
; {var832=java.lang.Object, var2363=r12, var985=$r1, var1961=$r0, var1966=$r2, var1374=clojure.core$seq__5486, var1119=r13, var2665=r14, var465=l4, var3028=l5, var2866=$b6, var1125=$i7, var265=r16}
; {java.lang.Object=var832, r12=var2363, $r1=var985, $r0=var1961, $r2=var1966, clojure.core$seq__5486=var1374, r13=var1119, r14=var2665, l4=var465, l5=var3028, $b6=var2866, $i7=var1125, r16=var265}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r12 := @parameter0: java.lang.Object;	$r1 = (java.lang.String) r12;	$r0 = (java.lang.String) "\n";	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>($r0);	r13 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>($r2);	r14 = null;	l4 = 0L;	l5 = 0L;	$b6 = l5 cmp l4;	$i7 = (int) $b6;	if $i7 >= 0 goto r16 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>(r13);	r16 = staticinvoke <clojure.core$seq__5486: java.lang.Object invokeStatic(java.lang.Object)>(r13);	if r16 == null goto return null;	return null
;block_num 4