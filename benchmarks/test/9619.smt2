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

(declare-sort var352 0)
(declare-sort var2359 0)
(declare-sort var2119 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var352) String)
(declare-fun var2359_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getGroup/1342955253 (var352) String)
(declare-fun getVersion/189836348 (var352) String)
(declare-fun var352_buildKey/1628109746 (String String String) String)
(declare-const null-var352 var352)
(declare-const null-String String)
(declare-const var415 var352) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var415 null-var352)))
(assert true)
(define-const var372 String (getPath/898047937 var415)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var928 Bool (var2359_isNotEmpty/-1251449450 var372)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert (not (= (ite var928 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var522 String (getPath/898047937 var415)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert (not (= var522 null-String))) ; Cond: $r5 != null 
(assert true)
(define-const var912 String (getGroup/1342955253 var415)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
(define-const var2369 String (getVersion/189836348 var415)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var65 String (var352_buildKey/1628109746 var522 var912 var2369)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r5, $r3, $r2) 
 ; Statement: return $r4 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var2359_isNotEmpty/-1251449450=([java.lang.String], boolean), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var352_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var352=org.apache.dubbo.common.URL, var415=r0, var372=$r1, var2359=org.apache.dubbo.common.utils.StringUtils, var928=$z0, var522=$r5, var2119=null_type, var912=$r3, var2369=$r2, var65=$r4}
; {org.apache.dubbo.common.URL=var352, r0=var415, $r1=var372, org.apache.dubbo.common.utils.StringUtils=var2359, $z0=var928, $r5=var522, null_type=var2119, $r3=var912, $r2=var2369, $r4=var65}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	goto [?= (branch)];	if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r5, $r3, $r2);	return $r4
;block_num 4