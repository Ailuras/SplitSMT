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

(declare-sort var1768 0)
(declare-sort var2667 0)
(declare-sort var187 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-553797664 (var187) void)
(declare-fun cast-from-var1768-to-var187 (var1768) var187)
(declare-fun mString/-1890708699 (var1768) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun mLimit/-1890708699 (var1768) Int)
(declare-fun mMark/-1890708699 (var1768) Int)
(declare-fun mPosition/-1890708699 (var1768) Int)
(declare-const null-var1768 var1768)
(declare-const null-String String)
(declare-const var2998 var1768) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringReader 
(assert (not (= var2998 null-var1768)))
(declare-const var2706 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2706 null-String)))
(assert true)
;(assert (<init>/-553797664 (cast-from-var1768-to-var187 var2998))) ; Statement: specialinvoke r0.<java.io.Reader: void <init>()>() 

(declare-const var2998!1 var1768)
(declare-const var2998!2 var1768)
(assert (not (= var2998!2 null-var1768)))
(assert (= (mString/-1890708699 var2998!2) var2706)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString> = r1 
(assert true)
(define-const var367 Int (length/-134980193 var2706)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(declare-const var2998!3 var1768)
(assert (not (= var2998!3 null-var1768)))
(assert (= (mLimit/-1890708699 var2998!3) var367)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mLimit> = $i0 
(declare-const var2998!4 var1768)
(assert (not (= var2998!4 null-var1768)))
(assert (= (mMark/-1890708699 var2998!4) 0)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mMark> = 0 
(declare-const var2998!5 var1768)
(assert (not (= var2998!5 null-var1768)))
(assert (= (mPosition/-1890708699 var2998!5) 0)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> = 0 
 ; Statement: return 
(check-sat)
; {<init>/-553797664=([java.io.Reader], void), cast-from-var1768-to-var187=([org.apache.dubbo.common.io.UnsafeStringReader], java.io.Reader), mString/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], java.lang.String), length/-134980193=([java.lang.String], int), mLimit/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], int), mMark/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], int), mPosition/-1890708699=([org.apache.dubbo.common.io.UnsafeStringReader], int)}
; {var1768=org.apache.dubbo.common.io.UnsafeStringReader, var2998=r0, var2706=r1, var2667=null_type, var187=java.io.Reader, var367=$i0}
; {org.apache.dubbo.common.io.UnsafeStringReader=var1768, r0=var2998, r1=var2706, null_type=var2667, java.io.Reader=var187, $i0=var367}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringReader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.io.Reader: void <init>()>();	r0.<org.apache.dubbo.common.io.UnsafeStringReader: java.lang.String mString> = r1;	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mLimit> = $i0;	r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mMark> = 0;	r0.<org.apache.dubbo.common.io.UnsafeStringReader: int mPosition> = 0;	return
;block_num 1