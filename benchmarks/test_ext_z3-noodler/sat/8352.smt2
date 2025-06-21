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

(declare-sort var1452 0)
(declare-sort var2592 0)
(declare-sort var2078 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2078_toCommaDelimitedString/1190858646 (String (Array Int String)) String)
(declare-fun services/-648787392 (var1452) String)
(declare-fun getThis/1652045011 (var1452) var1452)
(declare-const null-var1452 var1452)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var510 var1452) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder 
(assert (not (= var510 null-var1452)))
(declare-const var1667 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1667 null-String)))
(declare-const var1202 (Array Int String)) ; Statement: r2 := @parameter1: java.lang.String[] 
(assert (not (= var1202 null-__Array__Int__String__)))
(define-const var670 String (var2078_toCommaDelimitedString/1190858646 var1667 var1202)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toCommaDelimitedString(java.lang.String,java.lang.String[])>(r1, r2) 
(declare-const var510!1 var1452)
(assert (not (= var510!1 null-var1452)))
(assert (= (services/-648787392 var510!1) var670)) ; Statement: r0.<org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder: java.lang.String services> = $r3 
(assert true)
(define-const var3614 var1452 (getThis/1652045011 var510!1)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder: org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder getThis()>() 
 ; Statement: return $r4 
(check-sat)
; {var2078_toCommaDelimitedString/1190858646=([java.lang.String, java.lang.String[]], java.lang.String), services/-648787392=([org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder], java.lang.String), getThis/1652045011=([org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder], org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder)}
; {var1452=org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder, var510=r0, var1667=r1, var2592=null_type, var1202=r2, var2078=org.apache.dubbo.common.utils.StringUtils, var670=$r3, var3614=$r4}
; {org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder=var1452, r0=var510, r1=var1667, null_type=var2592, r2=var1202, org.apache.dubbo.common.utils.StringUtils=var2078, $r3=var670, $r4=var3614}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toCommaDelimitedString(java.lang.String,java.lang.String[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toCommaDelimitedString(java.lang.String,java.lang.String[])>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String[];	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toCommaDelimitedString(java.lang.String,java.lang.String[])>(r1, r2);	r0.<org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder: java.lang.String services> = $r3;	$r4 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder: org.apache.dubbo.config.bootstrap.builders.ReferenceBuilder getThis()>();	return $r4
;block_num 1