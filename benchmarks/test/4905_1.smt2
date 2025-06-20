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

(declare-sort var1612 0)
(declare-sort var2940 0)
(declare-sort var1611 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1612 String) String)
(declare-fun var1611_isEmpty/-813097145 (String) Bool)
(declare-const null-var1612 var1612)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2857 var1612) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2857 null-var1612)))
(declare-const var1152 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1152 null-String)))
(declare-const var537 (Array Int String)) ; Statement: r4 := @parameter1: java.lang.String[] 
(assert (not (= var537 null-__Array__Int__String__)))
(assert true)
(define-const var3920 String (getParameter/-1307325648 var2857 var1152)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1546 Bool (var1611_isEmpty/-813097145 var3920)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var1546 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1266 (Array Int String) var537) ; Statement: $r5 = r4 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1611_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1612=org.apache.dubbo.common.URL, var2857=r0, var1152=r1, var2940=null_type, var537=r4, var3920=r2, var1611=org.apache.dubbo.common.utils.StringUtils, var1546=$z0, var1266=$r5}
; {org.apache.dubbo.common.URL=var1612, r0=var2857, r1=var1152, null_type=var2940, r4=var537, r2=var3920, org.apache.dubbo.common.utils.StringUtils=var1611, $z0=var1546, $r5=var1266}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String[];	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r5 = r4;	goto [?= return $r5];	return $r5
;block_num 3