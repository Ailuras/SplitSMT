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

(declare-sort var178 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun root/-95734468 (var178) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var178 var178)
(declare-const var1706 var178) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1706 null-var178)))
(define-const var2326 String (root/-95734468 var1706)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root> 
(assert true)
(define-const var1690 Bool (= var2326 "/")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/") 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var1690 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1786 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1786)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1786!1 String)
(assert (= var1786!1 ""))
(define-const var249 String (root/-95734468 var1706)) ; Statement: $r3 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root> 
(assert true)
(define-const var349 String (append/672562846 var1786!1 var249)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1786!2 String)
(assert (= var1786!2 (str.++ var1786!1 var249)))
(assert true)
(define-const var1586 String (append/672562846 var349 "/")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var349!1 String)
(assert (= var349!1 (str.++ var349 "/")))
(assert true)
(define-const var119 String (toString/-2075883882 var1586)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {root/-95734468=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var178=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1706=r0, var2326=$r1, var1690=$z0, var1786=$r2, var249=$r3, var349=$r4, var1586=$r5, var119=$r6}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var178, r0=var1706, $r1=var2326, $z0=var1690, $r2=var1786, $r3=var249, $r4=var349, $r5=var1586, $r6=var119}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	$r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("/");	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: java.lang.String root>;	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 2