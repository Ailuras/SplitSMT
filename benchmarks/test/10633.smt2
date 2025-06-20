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

(declare-sort var2501 0)
(declare-sort var3346 0)
(declare-sort var911 0)
(declare-sort var2217 0)
(declare-sort var893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2501 String) String)
(declare-fun var2217_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setProperty/703705272 (var3346 String String) var893)
(declare-const null-var2501 var2501)
(declare-const null-var3346 var3346)
(declare-const null-String String)
(declare-const var3020 var2501) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3020 null-var2501)))
(declare-const var451 var3346) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var451 null-var3346)))
(declare-const var1229 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1229 null-String)))
(declare-const var2483 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var2483 null-String)))
(assert true)
(define-const var334 String (getParameter/-1307325648 var3020 var1229)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3732 Bool (var2217_isNotEmpty/-1251449450 var334)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 
(assert (not (= (ite var3732 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (setProperty/703705272 var451 var1229 var334)) ; Statement: virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2) 

(declare-const var451!1 var3346)
(declare-const var1229!1 String)
(declare-const var334!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2217_isNotEmpty/-1251449450=([java.lang.String], boolean), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object)}
; {var2501=org.apache.dubbo.common.URL, var3020=r0, var3346=java.util.Properties, var451=r3, var1229=r1, var911=null_type, var2483=r4, var334=r2, var2217=org.apache.dubbo.common.utils.StringUtils, var3732=$z0, var893=java.lang.Object}
; {org.apache.dubbo.common.URL=var2501, r0=var3020, java.util.Properties=var3346, r3=var451, r1=var1229, null_type=var911, r4=var2483, r2=var334, org.apache.dubbo.common.utils.StringUtils=var2217, $z0=var3732, java.lang.Object=var893}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2);	goto [?= return];	return
;block_num 3