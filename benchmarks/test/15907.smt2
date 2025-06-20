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

(declare-sort var3820 0)
(declare-sort var1654 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toCategoryPath/-1144719438 (var3820 var1654) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toFullString/-798704221 (var1654) String)
(declare-fun var1654_encode/1794151917 (String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3820 var3820)
(declare-const null-var1654 var1654)
(declare-const var2325 var3820) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var2325 null-var3820)))
(declare-const var377 var1654) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var377 null-var1654)))
(define-const var3944 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3944)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3944!1 String)
(assert (= var3944!1 ""))
(assert true)
(define-const var2889 String (toCategoryPath/-1144719438 var2325 var377)) ; Statement: $r3 = specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toCategoryPath(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var1019 String (append/672562846 var3944!1 var2889)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3944!2 String)
(assert (= var3944!2 (str.++ var3944!1 var2889)))
(assert true)
(define-const var697 String (append/672562846 var1019 "/")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var1019!1 String)
(assert (= var1019!1 (str.++ var1019 "/")))
(assert true)
(define-const var2345 String (toFullString/-798704221 var377)) ; Statement: $r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(define-const var2463 String (var1654_encode/1794151917 var2345)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>($r5) 
(assert true)
(define-const var2722 String (append/672562846 var697 var2463)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var697!1 String)
(assert (= var697!1 (str.++ var697 var2463)))
(assert true)
(define-const var2415 String (toString/-2075883882 var2722)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toCategoryPath/-1144719438=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), var1654_encode/1794151917=([java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3820=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var2325=r1, var1654=org.apache.dubbo.common.URL, var377=r2, var3944=$r0, var2889=$r3, var1019=$r4, var697=$r7, var2345=$r5, var2463=$r6, var2722=$r8, var2415=$r9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var3820, r1=var2325, org.apache.dubbo.common.URL=var1654, r2=var377, $r0=var3944, $r3=var2889, $r4=var1019, $r7=var697, $r5=var2345, $r6=var2463, $r8=var2722, $r9=var2415}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String toCategoryPath(org.apache.dubbo.common.URL)>(r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r5 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r6 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1