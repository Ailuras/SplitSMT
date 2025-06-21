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

(declare-sort var2721 0)
(declare-sort var2442 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-149410723 (Float32) String)
(declare-fun addParameter/1929860173 (var2721 String String) var2721)
(declare-const null-var2721 var2721)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var3359 var2721) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3359 null-var2721)))
(declare-const var3845 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3845 null-String)))
(declare-const var1234 Float32) ; Statement: f0 := @parameter1: float 
(assert (not (= var1234 null-Float32)))
(define-const var185 String (String_valueOf/-149410723 var1234)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0) 
(assert true)
(define-const var2751 var2721 (addParameter/1929860173 var3359 var3845 var185)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-149410723=([float], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var2721=org.apache.dubbo.common.URLBuilder, var3359=r0, var3845=r1, var2442=null_type, var1234=f0, var185=$r2, var2751=$r3}
; {org.apache.dubbo.common.URLBuilder=var2721, r0=var3359, r1=var3845, null_type=var2442, f0=var1234, $r2=var185, $r3=var2751}
;seq <java.lang.String: java.lang.String valueOf(float)>
;cnt {"<java.lang.String: java.lang.String valueOf(float)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	f0 := @parameter1: float;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1