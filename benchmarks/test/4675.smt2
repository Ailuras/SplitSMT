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

(declare-sort var1965 0)
(declare-sort var3178 0)
(declare-sort var2811 0)
(declare-sort var2418 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2811-init () var2811)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2418) String)
(declare-fun cast-from-var3178-to-var2418 (var3178) var2418)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2811 String) void)
(declare-const null-var1965 var1965)
(declare-const null-var3178 var3178)
(declare-const var263 var1965) ; Statement: r6 := @this: org.apache.dubbo.config.AbstractMethodConfig 
(assert (not (= var263 null-var1965)))
(declare-const var2256 var3178) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var2256 null-var3178)))
(define-const var181 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var181 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3307 var2811 var2811-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var3302 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3302)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3302!1 String)
(assert (= var3302!1 ""))
(assert true)
(define-const var1960 String (append/672562846 var3302!1 "Invalid scope model, expect to be a ModuleModel but got: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ModuleModel but got: ") 
(declare-const var3302!2 String)
(assert (= var3302!2 (str.++ var3302!1 "Invalid scope model, expect to be a ModuleModel but got: ")))
(assert true)
(define-const var119 String (append/-1031950772 var1960 (cast-from-var3178-to-var2418 var2256))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var1960!1 String)
(assert (str.prefixof var1960 var1960!1))
(assert true)
(define-const var604 String (toString/-2075883882 var119)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3307 var604)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5) 

(declare-const var3307!1 var2811)
(declare-const var604!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2811-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3178-to-var2418=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1965=org.apache.dubbo.config.AbstractMethodConfig, var263=r6, var3178=org.apache.dubbo.rpc.model.ScopeModel, var2256=r0, var181=$z0, var2811=java.lang.IllegalArgumentException, var3307=$r1, var3302=$r2, var1960=$r3, var2418=java.lang.Object, var119=$r4, var604=$r5}
; {org.apache.dubbo.config.AbstractMethodConfig=var1965, r6=var263, org.apache.dubbo.rpc.model.ScopeModel=var3178, r0=var2256, $z0=var181, java.lang.IllegalArgumentException=var2811, $r1=var3307, $r2=var3302, $r3=var1960, java.lang.Object=var2418, $r4=var119, $r5=var604}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.config.AbstractMethodConfig;	r0 := @parameter0: org.apache.dubbo.rpc.model.ScopeModel;	$z0 = r0 instanceof org.apache.dubbo.rpc.model.ModuleModel;	if $z0 != 0 goto return;	$r1 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid scope model, expect to be a ModuleModel but got: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r5);	throw $r1
;block_num 2