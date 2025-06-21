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

(declare-sort var3965 0)
(declare-sort var3012 0)
(declare-sort var57 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3965_getInteger/1948837305 (var3965 String Int) Int)
(declare-fun var57-init () var57)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1658509215 (var57 String) void)
(declare-const null-var3965 var3965)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var39 var3965) ; Statement: r0 := @this: org.apache.dubbo.common.config.Configuration 
(assert (not (= var39 null-var3965)))
(declare-const var2151 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2151 null-String)))
(define-const var1015 Int (var3965_getInteger/1948837305 var39 var2151 null-Int)) ; Statement: r2 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Integer getInteger(java.lang.String,java.lang.Integer)>(r1, null) 
 ; Statement: if r2 == null goto $r3 = new java.util.NoSuchElementException 
(assert (= var1015 null-Int)) ; Cond: r2 == null 
(define-const var3400 var57 var57-init) ; Statement: $r3 = new java.util.NoSuchElementException 
(define-const var231 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var231)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var231!1 String)
(assert (= var231!1 ""))
(assert true)
(define-const var2184 String (append/-1166366385 var231!1 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var231!2 String)
(assert (str.prefixof var231!1 var231!2))
(assert true)
(define-const var3841 String (append/672562846 var2184 var2151)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2184!1 String)
(assert (= var2184!1 (str.++ var2184 var2151)))
(assert true)
(define-const var3026 String (append/672562846 var3841 "\u0027 doesn\u0027t map to an existing object")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to an existing object") 
(declare-const var3841!1 String)
(assert (= var3841!1 (str.++ var3841 "\u0027 doesn\u0027t map to an existing object")))
(assert true)
(define-const var2039 String (toString/-2075883882 var3026)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1658509215 var3400 var2039)) ; Statement: specialinvoke $r3.<java.util.NoSuchElementException: void <init>(java.lang.String)>($r8) 

(declare-const var3400!1 var57)
(declare-const var2039!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var3965_getInteger/1948837305=([org.apache.dubbo.common.config.Configuration, java.lang.String, java.lang.Integer], java.lang.Integer), var57-init=([], java.util.NoSuchElementException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1658509215=([java.util.NoSuchElementException, java.lang.String], void)}
; {var3965=org.apache.dubbo.common.config.Configuration, var39=r0, var2151=r1, var3012=null_type, var1015=r2, var57=java.util.NoSuchElementException, var3400=$r3, var231=$r4, var2184=$r5, var3841=$r6, var3026=$r7, var2039=$r8}
; {org.apache.dubbo.common.config.Configuration=var3965, r0=var39, r1=var2151, null_type=var3012, r2=var1015, java.util.NoSuchElementException=var57, $r3=var3400, $r4=var231, $r5=var2184, $r6=var3841, $r7=var3026, $r8=var2039}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.Configuration;	r1 := @parameter0: java.lang.String;	r2 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Integer getInteger(java.lang.String,java.lang.Integer)>(r1, null);	if r2 == null goto $r3 = new java.util.NoSuchElementException;	$r3 = new java.util.NoSuchElementException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to an existing object");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.util.NoSuchElementException: void <init>(java.lang.String)>($r8);	throw $r3
;block_num 2