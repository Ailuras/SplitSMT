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

(declare-sort var1990 0)
(declare-sort var2107 0)
(declare-sort var519 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toRootDir/-1342168713 (var1990) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2107_getUniqueKey/218933863 (var2107 var519) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1990 var1990)
(declare-const null-var2107 var2107)
(declare-const var519-PATH var519)
(declare-const var3395 var1990) ; Statement: r1 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var3395 null-var1990)))
(declare-const var615 var2107) ; Statement: r3 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier 
(assert (not (= var615 null-var2107)))
(define-const var1858 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1858)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1858!1 String)
(assert (= var1858!1 ""))
(assert true)
(define-const var3552 String (toRootDir/-1342168713 var3395)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String toRootDir()>() 
(assert true)
(define-const var3260 String (append/672562846 var1858!1 var3552)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1858!2 String)
(assert (= var1858!2 (str.++ var1858!1 var3552)))
(define-const var186 var519 var519-PATH) ; Statement: $r4 = <org.apache.dubbo.metadata.report.identifier.KeyTypeEnum: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum PATH> 
(define-const var1019 String (var2107_getUniqueKey/218933863 var615 var186)) ; Statement: $r5 = interfaceinvoke r3.<org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier: java.lang.String getUniqueKey(org.apache.dubbo.metadata.report.identifier.KeyTypeEnum)>($r4) 
(assert true)
(define-const var2126 String (append/672562846 var3260 var1019)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3260!1 String)
(assert (= var3260!1 (str.++ var3260 var1019)))
(assert true)
(define-const var1444 String (toString/-2075883882 var2126)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toRootDir/-1342168713=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2107_getUniqueKey/218933863=([org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, org.apache.dubbo.metadata.report.identifier.KeyTypeEnum], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1990=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var3395=r1, var2107=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var615=r3, var1858=$r0, var3552=$r2, var3260=$r6, var519=org.apache.dubbo.metadata.report.identifier.KeyTypeEnum, var186=$r4, var1019=$r5, var2126=$r7, var1444=$r8}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var1990, r1=var3395, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var2107, r3=var615, $r0=var1858, $r2=var3552, $r6=var3260, org.apache.dubbo.metadata.report.identifier.KeyTypeEnum=var519, $r4=var186, $r5=var1019, $r7=var2126, $r8=var1444}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r3 := @parameter0: org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String toRootDir()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = <org.apache.dubbo.metadata.report.identifier.KeyTypeEnum: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum PATH>;	$r5 = interfaceinvoke r3.<org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier: java.lang.String getUniqueKey(org.apache.dubbo.metadata.report.identifier.KeyTypeEnum)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1