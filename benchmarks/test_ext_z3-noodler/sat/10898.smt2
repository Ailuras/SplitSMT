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

(declare-sort var831 0)
(declare-sort var3351 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-371898945 (Int) String)
(declare-fun addParameter/-180549847 (var831 String String) var831)
(declare-const null-var831 var831)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1259 var831) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var1259 null-var831)))
(declare-const var3047 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3047 null-String)))
(declare-const var1166 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var1166 null-Int)))
(define-const var2509 String (String_valueOf/-371898945 var1166)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0) 
(assert true)
(define-const var3476 var831 (addParameter/-180549847 var1259 var3047 var2509)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-371898945=([char], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var831=com.alibaba.dubbo.common.URL, var1259=r0, var3047=r1, var3351=null_type, var1166=c0, var2509=$r2, var3476=$r3}
; {com.alibaba.dubbo.common.URL=var831, r0=var1259, r1=var3047, null_type=var3351, c0=var1166, $r2=var2509, $r3=var3476}
;seq <java.lang.String: java.lang.String valueOf(char)>
;cnt {"<java.lang.String: java.lang.String valueOf(char)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1