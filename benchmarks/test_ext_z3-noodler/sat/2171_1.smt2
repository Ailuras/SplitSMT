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

(declare-sort var2225 0)
(declare-sort var613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getConfigNamespace/1077289561 (var2225 var613) String)
(declare-fun getConfigBasePath/-430069322 (var2225 var613) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2225 var2225)
(declare-const null-var613 var613)
(declare-const var1620 var2225) ; Statement: r1 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration 
(assert (not (= var1620 null-var2225)))
(declare-const var905 var613) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var905 null-var613)))
(define-const var3229 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3229)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3229!1 String)
(assert (= var3229!1 ""))
(assert true)
(define-const var3660 String (append/672562846 var3229!1 "/")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3229!2 String)
(assert (= var3229!2 (str.++ var3229!1 "/")))
(assert true)
(define-const var2060 String (getConfigNamespace/1077289561 var1620 var905)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String getConfigNamespace(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var3468 String (append/672562846 var3660 var2060)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3660!1 String)
(assert (= var3660!1 (str.++ var3660 var2060)))
(assert true)
(define-const var3514 String (getConfigBasePath/-430069322 var1620 var905)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String getConfigBasePath(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var589 String (append/672562846 var3468 var3514)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3468!1 String)
(assert (= var3468!1 (str.++ var3468 var3514)))
(assert true)
(define-const var3564 String (toString/-2075883882 var589)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getConfigNamespace/1077289561=([org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, org.apache.dubbo.common.URL], java.lang.String), getConfigBasePath/-430069322=([org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2225=org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, var1620=r1, var613=org.apache.dubbo.common.URL, var905=r2, var3229=$r0, var3660=$r4, var2060=$r3, var3468=$r6, var3514=$r5, var589=$r7, var3564=$r8}
; {org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration=var2225, r1=var1620, org.apache.dubbo.common.URL=var613, r2=var905, $r0=var3229, $r4=var3660, $r3=var2060, $r6=var3468, $r5=var3514, $r7=var589, $r8=var3564}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String getConfigNamespace(org.apache.dubbo.common.URL)>(r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration: java.lang.String getConfigBasePath(org.apache.dubbo.common.URL)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1