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

(declare-sort var3042 0)
(declare-sort var2512 0)
(declare-sort var1199 0)
(declare-sort var590 0)
(declare-sort var2153 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3042 String) String)
(declare-fun var590_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setProperty/703705272 (var2512 String String) var2153)
(declare-const null-var3042 var3042)
(declare-const null-var2512 var2512)
(declare-const null-String String)
(declare-const var2604 var3042) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2604 null-var3042)))
(declare-const var2275 var2512) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var2275 null-var2512)))
(declare-const var2364 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var2364 null-String)))
(declare-const var299 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var299 null-String)))
(assert true)
(define-const var3472 String (getParameter/-1307325648 var2604 var2364)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1275 Bool (var590_isNotEmpty/-1251449450 var3472)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 
(assert (= (ite var1275 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (setProperty/703705272 var2275 var2364 var299)) ; Statement: virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 

(declare-const var2275!1 var2512)
(declare-const var2364!1 String)
(declare-const var299!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var590_isNotEmpty/-1251449450=([java.lang.String], boolean), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object)}
; {var3042=org.apache.dubbo.common.URL, var2604=r0, var2512=java.util.Properties, var2275=r3, var2364=r1, var1199=null_type, var299=r4, var3472=r2, var590=org.apache.dubbo.common.utils.StringUtils, var1275=$z0, var2153=java.lang.Object}
; {org.apache.dubbo.common.URL=var3042, r0=var2604, java.util.Properties=var2512, r3=var2275, r1=var2364, null_type=var1199, r4=var299, r2=var3472, org.apache.dubbo.common.utils.StringUtils=var590, $z0=var1275, java.lang.Object=var2153}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	return
;block_num 3