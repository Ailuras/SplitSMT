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

(declare-sort var12 0)
(declare-sort var2847 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-371898945 (Int) String)
(declare-fun addParameter/-1629709269 (var12 String String) var12)
(declare-const null-var12 var12)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var797 var12) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var797 null-var12)))
(declare-const var3105 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3105 null-String)))
(declare-const var2887 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var2887 null-Int)))
(define-const var3280 String (String_valueOf/-371898945 var2887)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0) 
(assert true)
(define-const var3262 var12 (addParameter/-1629709269 var797 var3105 var3280)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-371898945=([char], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var12=org.apache.dubbo.common.URL, var797=r0, var3105=r1, var2847=null_type, var2887=c0, var3280=$r2, var3262=$r3}
; {org.apache.dubbo.common.URL=var12, r0=var797, r1=var3105, null_type=var2847, c0=var2887, $r2=var3280, $r3=var3262}
;seq <java.lang.String: java.lang.String valueOf(char)>
;cnt {"<java.lang.String: java.lang.String valueOf(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1