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

(declare-sort var1147 0)
(declare-sort var1084 0)
(declare-sort var3142 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var1147) String)
(declare-fun var1084_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getServiceInterface/-1311863806 (var1147) String)
(declare-fun getGroup/1342955253 (var1147) String)
(declare-fun getVersion/189836348 (var1147) String)
(declare-fun var1147_buildKey/1628109746 (String String String) String)
(declare-const null-var1147 var1147)
(declare-const null-String String)
(declare-const var2255 var1147) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2255 null-var1147)))
(assert true)
(define-const var2551 String (getPath/898047937 var2255)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var3863 Bool (var1084_isNotEmpty/-1251449450 var2551)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert (= (ite var3863 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3859 String (getServiceInterface/-1311863806 var2255)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true) ; Non Conditional
 ; Statement: if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert (not (= var3859 null-String))) ; Cond: $r5 != null 
(assert true)
(define-const var1790 String (getGroup/1342955253 var2255)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
(define-const var152 String (getVersion/189836348 var2255)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var3032 String (var1147_buildKey/1628109746 var3859 var1790 var152)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r5, $r3, $r2) 
 ; Statement: return $r4 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var1084_isNotEmpty/-1251449450=([java.lang.String], boolean), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var1147_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var1147=org.apache.dubbo.common.URL, var2255=r0, var2551=$r1, var1084=org.apache.dubbo.common.utils.StringUtils, var3863=$z0, var3859=$r5, var3142=null_type, var1790=$r3, var152=$r2, var3032=$r4}
; {org.apache.dubbo.common.URL=var1147, r0=var2255, $r1=var2551, org.apache.dubbo.common.utils.StringUtils=var1084, $z0=var3863, $r5=var3859, null_type=var3142, $r3=var1790, $r2=var152, $r4=var3032}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r5, $r3, $r2);	return $r4
;block_num 4