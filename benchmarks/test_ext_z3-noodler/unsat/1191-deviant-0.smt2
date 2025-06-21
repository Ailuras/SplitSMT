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

(declare-sort var1529 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-const null-String String)
(declare-const var855 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var855 null-String)))
(assert true)
(define-const var2064 Int (indexOf/-1209756239 var855 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
(assert true)
(define-const var1635 Int (indexOf/-1209756239 var855 ":")) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(define-const var2779 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if i0 != $i6 goto $i2 = i0 + 1 
(assert (not (not (= var2064 var2779)))) ; Negate: Cond: i0 != $i6  
(define-const var180 Int 0) ; Statement: $i2 = 0 
 ; Statement: goto [?= i3 = $i2] 
(assert true) ; Non Conditional
(define-const var834 Int var180) ; Statement: i3 = $i2 
(define-const var1350 Int (cast-from-Int-to-Int -1)) ; Statement: $i8 = (int) -1 
 ; Statement: if i1 != $i8 goto $i4 = i1 
(assert (not (= var1635 var1350))) ; Cond: i1 != $i8 
(define-const var889 Int var1635) ; Statement: $i4 = i1 
(assert true) ; Non Conditional
(assert (not (and true (and (>= var834 0) (>= (str.len var855) var889) (>= var889 var834)))))
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String)}
; {var855=r0, var1529=null_type, var2064=i0, var1635=i1, var2779=$i6, var180=$i2, var834=i3, var1350=$i8, var889=$i4, var1537=$r1}
; {r0=var855, null_type=var1529, i0=var2064, i1=var1635, $i6=var2779, $i2=var180, i3=var834, $i8=var1350, $i4=var889, $r1=var1537}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i6 = (int) -1;	if i0 != $i6 goto $i2 = i0 + 1;	$i2 = 0;	goto [?= i3 = $i2];	i3 = $i2;	$i8 = (int) -1;	if i1 != $i8 goto $i4 = i1;	$i4 = i1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4);	return $r1
;block_num 5