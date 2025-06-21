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

(declare-sort var2860 0)
(declare-sort var3773 0)
(declare-sort var2268 0)
(declare-sort var1722 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2268-init () var2268)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1722) String)
(declare-fun cast-from-var3773-to-var1722 (var3773) var1722)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2268 String) void)
(declare-const null-var2860 var2860)
(declare-const null-var3773 var3773)
(declare-const var1239 var2860) ; Statement: r6 := @this: org.apache.dubbo.config.ModuleConfig 
(assert (not (= var1239 null-var2860)))
(declare-const var1072 var3773) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1072 null-var3773)))
(define-const var3775 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var3775 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2046 var2268 var2268-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var2578 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2578)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2578!1 String)
(assert (= var2578!1 ""))
(assert true)
(define-const var3280 String (append/672562846 var2578!1 "Invalid scope model, expect to be a ModuleModel but got: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ModuleModel but got: ") 
(declare-const var2578!2 String)
(assert (= var2578!2 (str.++ var2578!1 "Invalid scope model, expect to be a ModuleModel but got: ")))
(assert true)
(define-const var1460 String (append/-1031950772 var3280 (cast-from-var3773-to-var1722 var1072))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var3280!1 String)
(assert (str.prefixof var3280 var3280!1))
(assert true)
(define-const var1997 String (toString/-2075883882 var1460)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2046 var1997)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5) 

(declare-const var2046!1 var2268)
(declare-const var1997!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2268-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3773-to-var1722=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2860=org.apache.dubbo.config.ModuleConfig, var1239=r6, var3773=org.apache.dubbo.rpc.model.ScopeModel, var1072=r0, var3775=$z0, var2268=java.lang.IllegalArgumentException, var2046=$r1, var2578=$r2, var3280=$r3, var1722=java.lang.Object, var1460=$r4, var1997=$r5}
; {org.apache.dubbo.config.ModuleConfig=var2860, r6=var1239, org.apache.dubbo.rpc.model.ScopeModel=var3773, r0=var1072, $z0=var3775, java.lang.IllegalArgumentException=var2268, $r1=var2046, $r2=var2578, $r3=var3280, java.lang.Object=var1722, $r4=var1460, $r5=var1997}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.config.ModuleConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel;	if $z0 != 0 goto return;	$r1 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ModuleModel but got: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5);	throw $r1
;block_num 2