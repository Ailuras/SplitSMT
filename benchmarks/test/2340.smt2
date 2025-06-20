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

(declare-sort var3005 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ensureOpen/-1787452232 (var3005) void)
(declare-fun mPosition/-1890708699 (var3005) Int)
(declare-fun mLimit/-1890708699 (var3005) Int)
(declare-fun mString/-1890708699 (var3005) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3005 var3005)
(declare-const var1563 var3005) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringReader 
(assert (not (= var1563 null-var3005)))
(assert true)
;(assert (ensureOpen/-1787452232 var1563)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.io.UnsafeStringReader: void ensureOpen()>() 

(declare-const var1563!1 var3005)
(define-const var3095 Int (mPosition/-1890708699 var1563!1)) ; Statement: $i1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> 
(define-const var3669 Int (mLimit/-1890708699 var1563!1)) ; Statement: $i0 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mLimit> 
 ; Statement: if $i1 < $i0 goto $r1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString> 
(assert (< var3095 var3669)) ; Cond: $i1 < $i0 
(define-const var3281 String (mString/-1890708699 var1563!1)) ; Statement: $r1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString> 
(define-const var1498 Int (mPosition/-1890708699 var1563!1)) ; Statement: $i2 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> 
(define-const var2382 Int (+ var1498 1)) ; Statement: $i3 = $i2 + 1 
(declare-const var1563!2 var3005)
(assert (not (= var1563!2 null-var3005)))
(assert (= (mPosition/-1890708699 var1563!2) var2382)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> = $i3 
(assert (and true (and (> (str.len var3281) var1498) (<= 0 var1498))))
(define-const var878 Int (charAt/698050440 var3281 var1498)) ; Statement: $c4 = virtualinvoke $r1.<java.lang.String: char charAt(int)>($i2) 
(define-const var3231 Int (cast-from-Int-to-Int var878)) ; Statement: $i7 = (int) $c4 
 ; Statement: return $i7 
(check-sat)
; {ensureOpen/-1787452232=([org.apache.dubbo.common.io.UnsafeStringReader], void), mPosition/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], int), mLimit/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], int), mString/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], java.lang.String), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var3005=org.apache.dubbo.common.io.UnsafeStringReader, var1563=r0, var3095=$i1, var3669=$i0, var3281=$r1, var1498=$i2, var2382=$i3, var878=$c4, var3231=$i7}
; {org.apache.dubbo.common.io.UnsafeStringReader=var3005, r0=var1563, $i1=var3095, $i0=var3669, $r1=var3281, $i2=var1498, $i3=var2382, $c4=var878, $i7=var3231}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringReader;	specialinvoke r0.<org.apache.dubbo.common.io.UnsafeStringReader: void ensureOpen()>();	$i1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition>;	$i0 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mLimit>;	if $i1 < $i0 goto $r1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString>;	$r1 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString>;	$i2 = r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition>;	$i3 = $i2 + 1;	r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> = $i3;	$c4 = virtualinvoke $r1.<java.lang.String: char charAt(int)>($i2);	$i7 = (int) $c4;	return $i7
;block_num 2