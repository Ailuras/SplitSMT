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

(declare-sort var3970 0)
(declare-sort var1762 0)
(declare-sort var1471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1762_values/1839078471 () (Array Int var1762))
(declare-fun getLength-Arr-var1762-1 ((Array Int var1762)) Int)
(declare-fun var1471-init () var1471)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1471 String) void)
(declare-const null-String String)
(declare-const var2392 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2392 null-String)))
(define-const var1327 (Array Int var1762) var1762_values/1839078471) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit[] values()>() 
(define-const var294 Int (getLength-Arr-var1762-1 var1327)) ; Statement: i0 = lengthof r0 
(define-const var903 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r1 = new java.lang.IllegalArgumentException 
(assert (>= var903 var294)) ; Cond: i1 >= i0 
(define-const var3597 var1471 var1471-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var1684 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1684)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1684!1 String)
(assert (= var1684!1 ""))
(assert true)
(define-const var311 String (append/672562846 var1684!1 "Unknown unit \u0027")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown unit \'") 
(declare-const var1684!2 String)
(assert (= var1684!2 (str.++ var1684!1 "Unknown unit \u0027")))
(assert true)
(define-const var751 String (append/672562846 var311 var2392)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var311!1 String)
(assert (= var311!1 (str.++ var311 var2392)))
(assert true)
(define-const var1159 String (append/672562846 var751 "\u0027")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'") 
(declare-const var751!1 String)
(assert (= var751!1 (str.++ var751 "\u0027")))
(assert true)
(define-const var3105 String (toString/-2075883882 var1159)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3597 var3105)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var3597!1 var1471)
(declare-const var3105!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var1762_values/1839078471=([], org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit[]), getLength-Arr-var1762-1=([org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit[]], int), var1471-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2392=r3, var3970=null_type, var1762=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit, var1327=r0, var294=i0, var903=i1, var1471=java.lang.IllegalArgumentException, var3597=$r1, var1684=$r2, var311=$r4, var751=$r5, var1159=$r6, var3105=$r7}
; {r3=var2392, null_type=var3970, org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit=var1762, r0=var1327, i0=var294, i1=var903, java.lang.IllegalArgumentException=var1471, $r1=var3597, $r2=var1684, $r4=var311, $r5=var751, $r6=var1159, $r7=var3105}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle$TimeUnit[] values()>();	i0 = lengthof r0;	i1 = 0;	if i1 >= i0 goto $r1 = new java.lang.IllegalArgumentException;	$r1 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown unit \'");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 3