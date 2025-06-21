(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var452 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-const null-String String)
(declare-const var3135 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3135 null-String)))
(assert true)
(define-const var1904 Int (indexOf/-1209756239 var3135 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
(assert true)
(define-const var153 Int (indexOf/-1209756239 var3135 ":")) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(define-const var468 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if i0 != $i6 goto $i2 = i0 + 1 
(assert (not (= var1904 var468))) ; Cond: i0 != $i6 
(define-const var1946 Int (+ var1904 1)) ; Statement: $i2 = i0 + 1 
(assert true) ; Non Conditional
(define-const var2736 Int var1946) ; Statement: i3 = $i2 
(define-const var2780 Int (cast-from-Int-to-Int -1)) ; Statement: $i8 = (int) -1 
 ; Statement: if i1 != $i8 goto $i4 = i1 
(assert (not (= var153 var2780))) ; Cond: i1 != $i8 
(define-const var1142 Int var153) ; Statement: $i4 = i1 
(assert true) ; Non Conditional
(assert (and true (and (>= var2736 0) (>= (str.len var3135) var1142) (>= var1142 var2736))))
(define-const var1381 String (substring/-1240304868 var3135 var2736 var1142)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4) 
 ; Statement: return $r1 
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String)}
; {var3135=r0, var452=null_type, var1904=i0, var153=i1, var468=$i6, var1946=$i2, var2736=i3, var2780=$i8, var1142=$i4, var1381=$r1}
; {r0=var3135, null_type=var452, i0=var1904, i1=var153, $i6=var468, $i2=var1946, i3=var2736, $i8=var2780, $i4=var1142, $r1=var1381}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i6 = (int) -1;	if i0 != $i6 goto $i2 = i0 + 1;	$i2 = i0 + 1;	i3 = $i2;	$i8 = (int) -1;	if i1 != $i8 goto $i4 = i1;	$i4 = i1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4);	return $r1
;block_num 5