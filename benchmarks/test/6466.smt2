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

(declare-sort var1777 0)
(declare-sort var1237 0)
(declare-sort var174 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1237!class ClassObject)
(declare-fun getAnnotation/-664766848 (ClassObject ClassObject) var1777)
(declare-fun cast-from-var1777-to-var1237 (var1777) var1237)
(declare-fun var174-init () var174)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var174 String) void)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1237 var1237)
(declare-const var3252 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var3252 null-ClassObject)))
(assert true)
(define-const var2683 var1777 (getAnnotation/-664766848 var3252 var1237!class)) ; Statement: $r1 = virtualinvoke r0.<java.lang.Class: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/SPI;") 
(define-const var2141 var1237 (cast-from-var1777-to-var1237 var2683)) ; Statement: r2 = (org.apache.dubbo.common.extension.SPI) $r1 
 ; Statement: if r2 != null goto $r3 = <org.apache.dubbo.rpc.model.ScopeModelUtil$1: int[] $SwitchMap$org$apache$dubbo$common$extension$ExtensionScope> 
(assert (not (not (= var2141 null-var1237)))) ; Negate: Cond: r2 != null  
(define-const var2016 var174 var174-init) ; Statement: $r15 = new java.lang.IllegalArgumentException 
(define-const var431 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var431)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var431!1 String)
(assert (= var431!1 ""))
(assert true)
(define-const var3151 String (append/672562846 var431!1 "SPI annotation not found for class: ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SPI annotation not found for class: ") 
(declare-const var431!2 String)
(assert (= var431!2 (str.++ var431!1 "SPI annotation not found for class: ")))
(assert true)
(define-const var3691 String (getName/-1958580599 var3252)) ; Statement: $r17 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1505 String (append/672562846 var3151 var3691)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3151!1 String)
(assert (= var3151!1 (str.++ var3151 var3691)))
(assert true)
(define-const var136 String (toString/-2075883882 var1505)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2016 var136)) ; Statement: specialinvoke $r15.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r20) 

(declare-const var2016!1 var174)
(declare-const var136!1 String)
 ; Statement: throw $r15 
(check-sat)
; {getAnnotation/-664766848=([java.lang.Class, java.lang.Class], java.lang.annotation.Annotation), cast-from-var1777-to-var1237=([java.lang.annotation.Annotation], org.apache.dubbo.common.extension.SPI), var174-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3252=r0, var1777=java.lang.annotation.Annotation, var1237=org.apache.dubbo.common.extension.SPI, var2683=$r1, var2141=r2, var174=java.lang.IllegalArgumentException, var2016=$r15, var431=$r16, var3151=$r18, var3691=$r17, var1505=$r19, var136=$r20}
; {r0=var3252, java.lang.annotation.Annotation=var1777, org.apache.dubbo.common.extension.SPI=var1237, $r1=var2683, r2=var2141, java.lang.IllegalArgumentException=var174, $r15=var2016, $r16=var431, $r18=var3151, $r17=var3691, $r19=var1505, $r20=var136}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	$r1 = virtualinvoke r0.<java.lang.Class: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/SPI;");	r2 = (org.apache.dubbo.common.extension.SPI) $r1;	if r2 != null goto $r3 = <org.apache.dubbo.rpc.model.ScopeModelUtil$1: int[] $SwitchMap$org$apache$dubbo$common$extension$ExtensionScope>;	$r15 = new java.lang.IllegalArgumentException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("SPI annotation not found for class: ");	$r17 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r15.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r20);	throw $r15
;block_num 2