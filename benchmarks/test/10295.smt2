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

(declare-sort var1077 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/1812918887 (var1077) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1077 var1077)
(declare-const var3404 var1077) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var3404 null-var1077)))
(define-const var1542 String (root/1812918887 var3404)) ; Statement: $r1 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root> 
(assert true)
(define-const var387 Bool (= var1542 "/")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/") 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var387 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3642 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3642)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3642!1 String)
(assert (= var3642!1 ""))
(define-const var2019 String (root/1812918887 var3404)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root> 
(assert true)
(define-const var3539 String (append/672562846 var3642!1 var2019)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3642!2 String)
(assert (= var3642!2 (str.++ var3642!1 var2019)))
(assert true)
(define-const var504 String (append/672562846 var3539 "/")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3539!1 String)
(assert (= var3539!1 (str.++ var3539 "/")))
(assert true)
(define-const var1750 String (toString/-2075883882 var504)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {root/1812918887=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1077=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var3404=r0, var1542=$r1, var387=$z0, var3642=$r2, var2019=$r3, var3539=$r4, var504=$r5, var1750=$r6}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var1077, r0=var3404, $r1=var1542, $z0=var387, $r2=var3642, $r3=var2019, $r4=var3539, $r5=var504, $r6=var1750}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	$r1 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/");	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = r0.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String root>;	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 2