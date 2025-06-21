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

(declare-sort var3638 0)
(declare-sort var3554 0)
(declare-sort var2180 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/624895015 (var3638) Bool)
(declare-fun var3554-init () var3554)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun url/1800549272 (var2180) String)
(declare-fun cast-from-var3638-to-var2180 (var3638) var2180)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3554 String) void)
(declare-const null-var3638 var3638)
(declare-const null-Bool Bool)
(declare-const var1528 var3638) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1528 null-var3638)))
(declare-const var3592 Bool) ; Statement: z2 := @parameter0: boolean 
(assert (not (= var3592 null-Bool)))
(define-const var2959 Bool (destroyed/624895015 var1528)) ; Statement: $z0 = r0.<org.apache.dubbo.config.ReferenceConfig: boolean destroyed> 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.Object ref> 
(assert (not (= (ite var2959 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2007 var3554 var3554-init) ; Statement: $r7 = new java.lang.IllegalStateException 
(define-const var694 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var694)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var694!1 String)
(assert (= var694!1 ""))
(assert true)
(define-const var1611 String (append/672562846 var694!1 "The invoker of ReferenceConfig(")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The invoker of ReferenceConfig(") 
(declare-const var694!2 String)
(assert (= var694!2 (str.++ var694!1 "The invoker of ReferenceConfig(")))
(define-const var2750 String (url/1800549272 (cast-from-var3638-to-var2180 var1528))) ; Statement: $r9 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url> 
(assert true)
(define-const var3767 String (append/672562846 var1611 var2750)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1611!1 String)
(assert (= var1611!1 (str.++ var1611 var2750)))
(assert true)
(define-const var3999 String (append/672562846 var3767 ") has already destroyed!")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") has already destroyed!") 
(declare-const var3767!1 String)
(assert (= var3767!1 (str.++ var3767 ") has already destroyed!")))
(assert true)
(define-const var1370 String (toString/-2075883882 var3999)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2007 var1370)) ; Statement: specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r13) 

(declare-const var2007!1 var3554)
(declare-const var1370!1 String)
 ; Statement: throw $r7 
(check-sat)
; {destroyed/624895015=([org.apache.dubbo.config.ReferenceConfig], boolean), var3554-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), url/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), cast-from-var3638-to-var2180=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.ReferenceConfigBase), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3638=org.apache.dubbo.config.ReferenceConfig, var1528=r0, var3592=z2, var2959=$z0, var3554=java.lang.IllegalStateException, var2007=$r7, var694=$r8, var1611=$r10, var2180=org.apache.dubbo.config.ReferenceConfigBase, var2750=$r9, var3767=$r11, var3999=$r12, var1370=$r13}
; {org.apache.dubbo.config.ReferenceConfig=var3638, r0=var1528, z2=var3592, $z0=var2959, java.lang.IllegalStateException=var3554, $r7=var2007, $r8=var694, $r10=var1611, org.apache.dubbo.config.ReferenceConfigBase=var2180, $r9=var2750, $r11=var3767, $r12=var3999, $r13=var1370}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	z2 := @parameter0: boolean;	$z0 = r0.<org.apache.dubbo.config.ReferenceConfig: boolean destroyed>;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.Object ref>;	$r7 = new java.lang.IllegalStateException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The invoker of ReferenceConfig(");	$r9 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") has already destroyed!");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r13);	throw $r7
;block_num 2