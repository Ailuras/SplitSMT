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

(declare-sort var3462 0)
(declare-sort var2942 0)
(declare-sort var2019 0)
(declare-sort var3286 0)
(declare-sort var3075 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3462 String) String)
(declare-fun var3286_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setProperty/703705272 (var2942 String String) var3075)
(declare-const null-var3462 var3462)
(declare-const null-var2942 var2942)
(declare-const null-String String)
(declare-const var2361 var3462) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2361 null-var3462)))
(declare-const var117 var2942) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var117 null-var2942)))
(declare-const var353 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var353 null-String)))
(declare-const var3717 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var3717 null-String)))
(assert true)
(define-const var1554 String (getParameter/-1307325648 var2361 var353)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1559 Bool (var3286_isNotEmpty/-1251449450 var1554)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 
(assert (not (= (ite var1559 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (setProperty/703705272 var117 var353 var1554)) ; Statement: virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2) 

(declare-const var117!1 var2942)
(declare-const var353!1 String)
(declare-const var1554!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3286_isNotEmpty/-1251449450=([java.lang.String], boolean), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object)}
; {var3462=org.apache.dubbo.common.URL, var2361=r0, var2942=java.util.Properties, var117=r3, var353=r1, var2019=null_type, var3717=r4, var1554=r2, var3286=org.apache.dubbo.common.utils.StringUtils, var1559=$z0, var3075=java.lang.Object}
; {org.apache.dubbo.common.URL=var3462, r0=var2361, java.util.Properties=var2942, r3=var117, r1=var353, null_type=var2019, r4=var3717, r2=var1554, org.apache.dubbo.common.utils.StringUtils=var3286, $z0=var1559, java.lang.Object=var3075}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2);	goto [?= return];	return
;block_num 3