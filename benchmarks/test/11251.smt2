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

(declare-sort var2164 0)
(declare-sort var1449 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toRootDir/-1342168713 (var2164) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2164 var2164)
(declare-const null-String String)
(declare-const var704 var2164) ; Statement: r1 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport 
(assert (not (= var704 null-var2164)))
(declare-const var3492 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3492 null-String)))
(declare-const var780 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var780 null-String)))
(define-const var2719 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2719)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2719!1 String)
(assert (= var2719!1 ""))
(assert true)
(define-const var761 String (toRootDir/-1342168713 var704)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String toRootDir()>() 
(assert true)
(define-const var3373 String (append/672562846 var2719!1 var761)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2719!2 String)
(assert (= var2719!2 (str.++ var2719!1 var761)))
(assert true)
(define-const var369 String (append/672562846 var3373 var3492)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var3373!1 String)
(assert (= var3373!1 (str.++ var3373 var3492)))
(assert true)
(define-const var3699 String (append/672562846 var369 "/")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var369!1 String)
(assert (= var369!1 (str.++ var369 "/")))
(assert true)
(define-const var2092 String (append/672562846 var3699 var780)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var3699!1 String)
(assert (= var3699!1 (str.++ var3699 var780)))
(assert true)
(define-const var250 String (toString/-2075883882 var2092)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toRootDir/-1342168713=([org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2164=org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport, var704=r1, var3492=r3, var1449=null_type, var780=r6, var2719=$r0, var761=$r2, var3373=$r4, var369=$r5, var3699=$r7, var2092=$r8, var250=$r9}
; {org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport=var2164, r1=var704, r3=var3492, null_type=var1449, r6=var780, $r0=var2719, $r2=var761, $r4=var3373, $r5=var369, $r7=var3699, $r8=var2092, $r9=var250}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport;	r3 := @parameter0: java.lang.String;	r6 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.metadata.store.zookeeper.ZookeeperMetadataReport: java.lang.String toRootDir()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1