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

(declare-sort var3264 0)
(declare-sort var2404 0)
(declare-sort var2927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var3264) String)
(declare-fun var2404_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3264 var3264)
(declare-const null-String String)
(declare-const var3864 var3264) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3864 null-var3264)))
(assert true)
(define-const var2068 String (getPath/898047937 var3864)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var775 Bool (var2404_isNotEmpty/-1251449450 var2068)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert (not (= (ite var775 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1138 String (getPath/898047937 var3864)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert (not (not (= var1138 null-String)))) ; Negate: Cond: $r5 != null  
 ; Statement: return null 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var2404_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3264=org.apache.dubbo.common.URL, var3864=r0, var2068=$r1, var2404=org.apache.dubbo.common.utils.StringUtils, var775=$z0, var1138=$r5, var2927=null_type}
; {org.apache.dubbo.common.URL=var3264, r0=var3864, $r1=var2068, org.apache.dubbo.common.utils.StringUtils=var2404, $z0=var775, $r5=var1138, null_type=var2927}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	goto [?= (branch)];	if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	return null
;block_num 4