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

(declare-sort var3178 0)
(declare-sort var2573 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mBuffer/-1735303467 (var3178) String)
(declare-fun append/50905802 (String String Int Int) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3178 var3178)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2005 var3178) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var2005 null-var3178)))
(declare-const var1122 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1122 null-String)))
(declare-const var3066 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3066 null-Int)))
(declare-const var3124 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3124 null-Int)))
(define-const var3331 String (mBuffer/-1735303467 var2005)) ; Statement: $r2 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> 
(define-const var2468 Int (+ var3066 var3124)) ; Statement: $i2 = i0 + i1 
(assert true)
;(assert (append/50905802 var3331 (cast-from-String-to-String var1122) var3066 var2468)) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.CharSequence,int,int)>(r1, i0, $i2) 
(declare-const var3331!1 String)
(assert (str.prefixof var3331 var3331!1))
 ; Statement: return 
(check-sat)
; {mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), append/50905802=([java.lang.StringBuilder, java.lang.CharSequence, int, int], java.lang.StringBuilder), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3178=org.apache.dubbo.common.io.UnsafeStringWriter, var2005=r0, var1122=r1, var2573=null_type, var3066=i0, var3124=i1, var3331=$r2, var2468=$i2}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var3178, r0=var2005, r1=var1122, null_type=var2573, i0=var3066, i1=var3124, $r2=var3331, $i2=var2468}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.CharSequence,int,int)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.CharSequence,int,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	i1 := @parameter2: int;	$r2 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer>;	$i2 = i0 + i1;	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.CharSequence,int,int)>(r1, i0, $i2);	return
;block_num 1