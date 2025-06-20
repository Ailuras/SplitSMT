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

(declare-sort var886 0)
(declare-sort var3585 0)
(declare-sort var1840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isStopping/-1094627107 (var3585) Bool)
(declare-fun cast-from-var886-to-var3585 (var886) var3585)
(declare-fun var1840-init () var1840)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getIdentifier/-338683473 (var3585) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1840 String) void)
(declare-const null-var886 var886)
(declare-const var1507 var886) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var1507 null-var886)))
(assert true)
(define-const var2136 Bool (isStopping/-1094627107 (cast-from-var886-to-var3585 var1507))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: boolean isStopping()>() 
 ; Statement: if $z0 != 0 goto $r19 = new java.lang.IllegalStateException 
(assert (not (= (ite var2136 1 0) 0))) ; Cond: $z0 != 0 
(define-const var250 var1840 var1840-init) ; Statement: $r19 = new java.lang.IllegalStateException 
(define-const var103 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var103)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var103!1 String)
(assert (= var103!1 ""))
(assert true)
(define-const var3990 String (getIdentifier/-338683473 (cast-from-var886-to-var3585 var1507))) ; Statement: $r21 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var500 String (append/672562846 var103!1 var3990)) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var103!2 String)
(assert (= var103!2 (str.++ var103!1 var3990)))
(assert true)
(define-const var3876 String (append/672562846 var500 " is stopping or stopped, can not start again")) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is stopping or stopped, can not start again") 
(declare-const var500!1 String)
(assert (= var500!1 (str.++ var500 " is stopping or stopped, can not start again")))
(assert true)
(define-const var3953 String (toString/-2075883882 var3876)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var250 var3953)) ; Statement: specialinvoke $r19.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r24) 

(declare-const var250!1 var1840)
(declare-const var3953!1 String)
 ; Statement: throw $r19 
(check-sat)
; {isStopping/-1094627107=([org.apache.dubbo.common.deploy.AbstractDeployer], boolean), cast-from-var886-to-var3585=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), var1840-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var886=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var1507=r0, var3585=org.apache.dubbo.common.deploy.AbstractDeployer, var2136=$z0, var1840=java.lang.IllegalStateException, var250=$r19, var103=$r20, var3990=$r21, var500=$r22, var3876=$r23, var3953=$r24}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var886, r0=var1507, org.apache.dubbo.common.deploy.AbstractDeployer=var3585, $z0=var2136, java.lang.IllegalStateException=var1840, $r19=var250, $r20=var103, $r21=var3990, $r22=var500, $r23=var3876, $r24=var3953}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	$z0 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: boolean isStopping()>();	if $z0 != 0 goto $r19 = new java.lang.IllegalStateException;	$r19 = new java.lang.IllegalStateException;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is stopping or stopped, can not start again");	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r19.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r24);	throw $r19
;block_num 2