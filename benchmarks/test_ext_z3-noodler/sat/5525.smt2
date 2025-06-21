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

(declare-sort var7 0)
(declare-sort var3520 0)
(declare-sort var216 0)
(declare-sort var45 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var216-init () var216)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var45) String)
(declare-fun cast-from-var3520-to-var45 (var3520) var45)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var216 String) void)
(declare-const null-var7 var7)
(declare-const null-var3520 var3520)
(declare-const var3397 var7) ; Statement: r6 := @this: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3397 null-var7)))
(declare-const var3758 var3520) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var3758 null-var3520)))
(define-const var3741 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ApplicationModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var3741 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3387 var216 var216-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var285 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var285)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var285!1 String)
(assert (= var285!1 ""))
(assert true)
(define-const var1345 String (append/672562846 var285!1 "Invalid scope model, expect to be a ApplicationModel but got: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ApplicationModel but got: ") 
(declare-const var285!2 String)
(assert (= var285!2 (str.++ var285!1 "Invalid scope model, expect to be a ApplicationModel but got: ")))
(assert true)
(define-const var502 String (append/-1031950772 var1345 (cast-from-var3520-to-var45 var3758))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var1345!1 String)
(assert (str.prefixof var1345 var1345!1))
(assert true)
(define-const var2003 String (toString/-2075883882 var502)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3387 var2003)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5) 

(declare-const var3387!1 var216)
(declare-const var2003!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var216-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3520-to-var45=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var7=org.apache.dubbo.config.AbstractConfig, var3397=r6, var3520=org.apache.dubbo.rpc.model.ScopeModel, var3758=r0, var3741=$z0, var216=java.lang.IllegalArgumentException, var3387=$r1, var285=$r2, var1345=$r3, var45=java.lang.Object, var502=$r4, var2003=$r5}
; {org.apache.dubbo.config.AbstractConfig=var7, r6=var3397, org.apache.dubbo.rpc.model.ScopeModel=var3520, r0=var3758, $z0=var3741, java.lang.IllegalArgumentException=var216, $r1=var3387, $r2=var285, $r3=var1345, java.lang.Object=var45, $r4=var502, $r5=var2003}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.config.AbstractConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ApplicationModel;	if $z0 != 0 goto return;	$r1 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ApplicationModel but got: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5);	throw $r1
;block_num 2