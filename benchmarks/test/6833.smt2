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

(declare-sort var1866 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-fun lastIndexOf/-618837785 (String String) Int)
(declare-const null-String String)
(declare-const var478 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var478 null-String)))
(assert (and true (and (> (str.len var478) 0) (<= 0 0))))
(define-const var608 Int (charAt/698050440 var478 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var2620 Int (cast-from-Int-to-Int var608)) ; Statement: $i4 = (int) $c0 
 ; Statement: if $i4 != 91 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(assert (not (= var2620 91))) ; Cond: $i4 != 91 
(assert true)
(define-const var872 Int (indexOf/-1209756239 var478 ":")) ; Statement: $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(assert true)
(define-const var1730 Int (lastIndexOf/-618837785 var478 ":")) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(java.lang.String)>(":") 
 ; Statement: if $i2 == $i1 goto return 0 
(assert (not (= var872 var1730))) ; Negate: Cond: $i2 == $i1  
 ; Statement: return 1 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), indexOf/-1209756239=([java.lang.String, java.lang.String], int), lastIndexOf/-618837785=([java.lang.String, java.lang.String], int)}
; {var478=r0, var1866=null_type, var608=$c0, var2620=$i4, var872=$i2, var1730=$i1}
; {r0=var478, null_type=var1866, $c0=var608, $i4=var2620, $i2=var872, $i1=var1730}
;seq <java.lang.String: char charAt(int)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int lastIndexOf(java.lang.String)>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: int lastIndexOf(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i4 = (int) $c0;	if $i4 != 91 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(java.lang.String)>(":");	if $i2 == $i1 goto return 0;	return 1
;block_num 3