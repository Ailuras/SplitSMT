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

(declare-sort var3714 0)
(declare-sort var954 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-149410723 (Float32) String)
(declare-fun addParameter/-1629709269 (var3714 String String) var3714)
(declare-const null-var3714 var3714)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var324 var3714) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var324 null-var3714)))
(declare-const var2580 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2580 null-String)))
(declare-const var451 Float32) ; Statement: f0 := @parameter1: float 
(assert (not (= var451 null-Float32)))
(define-const var2931 String (String_valueOf/-149410723 var451)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0) 
(assert true)
(define-const var853 var3714 (addParameter/-1629709269 var324 var2580 var2931)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-149410723=([float], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var3714=org.apache.dubbo.common.URL, var324=r0, var2580=r1, var954=null_type, var451=f0, var2931=$r2, var853=$r3}
; {org.apache.dubbo.common.URL=var3714, r0=var324, r1=var2580, null_type=var954, f0=var451, $r2=var2931, $r3=var853}
;seq <java.lang.String: java.lang.String valueOf(float)>
;cnt {"<java.lang.String: java.lang.String valueOf(float)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	f0 := @parameter1: float;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1