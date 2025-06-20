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

(declare-sort var1338 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-const null-String String)
(declare-const var2001 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2001 null-String)))
(assert (and true (and (> (str.len var2001) 0) (<= 0 0))))
(define-const var2997 Int (charAt/698050440 var2001 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var3009 Int (cast-from-Int-to-Int var2997)) ; Statement: $i4 = (int) $c0 
 ; Statement: if $i4 != 91 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(assert (not (not (= var3009 91)))) ; Negate: Cond: $i4 != 91  
(assert true)
(define-const var1919 Int (indexOf/-1037706067 var2001 93)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(93) 
 ; Statement: if $i3 <= 2 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(assert (not (<= var1919 2))) ; Negate: Cond: $i3 <= 2  
 ; Statement: return 1 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), indexOf/-1037706067=([java.lang.String, int], int)}
; {var2001=r0, var1338=null_type, var2997=$c0, var3009=$i4, var1919=$i3}
; {r0=var2001, null_type=var1338, $c0=var2997, $i4=var3009, $i3=var1919}
;seq <java.lang.String: char charAt(int)>;	<java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<java.lang.String: int indexOf(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$i4 = (int) $c0;	if $i4 != 91 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i3 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(93);	if $i3 <= 2 goto $i2 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	return 1
;block_num 3