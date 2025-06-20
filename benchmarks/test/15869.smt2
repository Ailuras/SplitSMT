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

(declare-sort var2592 0)
(declare-sort var22 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var22) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toRootDir/123354626 (var2592) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var22_encode/1794151917 (String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2592 var2592)
(declare-const null-var22 var22)
(declare-const var2671 var2592) ; Statement: r4 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var2671 null-var2592)))
(declare-const var3976 var22) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3976 null-var22)))
(assert true)
(define-const var3378 String (getServiceInterface/-1311863806 var3976)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var2049 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var3299 Bool (= var2049 var3378)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.StringBuilder 
(assert (= (ite var3299 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3995 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3995)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3995!1 String)
(assert (= var3995!1 ""))
(assert true)
(define-const var2352 String (toRootDir/123354626 var2671)) ; Statement: $r5 = specialinvoke r4.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toRootDir()>() 
(assert true)
(define-const var3037 String (append/672562846 var3995!1 var2352)) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3995!2 String)
(assert (= var3995!2 (str.++ var3995!1 var2352)))
(define-const var2066 String (var22_encode/1794151917 var3378)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r1) 
(assert true)
(define-const var982 String (append/672562846 var3037 var2066)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3037!1 String)
(assert (= var3037!1 (str.++ var3037 var2066)))
(assert true)
(define-const var1783 String (toString/-2075883882 var982)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toRootDir/123354626=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var22_encode/1794151917=([java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2592=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var2671=r4, var22=org.apache.dubbo.common.URL, var3976=r0, var3378=r1, var2049=$r2, var3299=$z0, var3995=$r3, var2352=$r5, var3037=$r7, var2066=$r6, var982=$r8, var1783=$r9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var2592, r4=var2671, org.apache.dubbo.common.URL=var22, r0=var3976, r1=var3378, $r2=var2049, $z0=var3299, $r3=var3995, $r5=var2352, $r7=var3037, $r6=var2066, $r8=var982, $r9=var1783}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r2 = "*";	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 == 0 goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = specialinvoke r4.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toRootDir()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2