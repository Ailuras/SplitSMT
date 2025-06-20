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

(declare-sort var2213 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2213_getTagName/1081555567 (ClassObject) String)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const var1446 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var1446 null-ClassObject)))
(define-const var2367 String (var2213_getTagName/1081555567 var1446)) ; Statement: r1 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTagName(java.lang.Class)>(r0) 
(assert true)
(define-const var3453 Bool (endsWith/985337093 var2367 "y")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("y") 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("s") 
(assert (not (= (ite var3453 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var968 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var968)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var968!1 String)
(assert (= var968!1 ""))
(assert true)
(define-const var1165 Int (length/-134980193 var2367)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var2779 Int (- var1165 1)) ; Statement: $i1 = $i0 - 1 
(assert (not (and true (and (>= 0 0) (>= (str.len var2367) var2779) (>= var2779 0)))))
(check-sat)
; {var2213_getTagName/1081555567=([java.lang.Class], java.lang.String), endsWith/985337093=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1446=r0, var2213=org.apache.dubbo.config.AbstractConfig, var2367=r1, var3453=$z0, var968=$r10, var1165=$i0, var2779=$i1, var3702=$r11, var3280=$r12, var805=$r13, var1702=$r14}
; {r0=var1446, org.apache.dubbo.config.AbstractConfig=var2213, r1=var2367, $z0=var3453, $r10=var968, $i0=var1165, $i1=var2779, $r11=var3702, $r12=var3280, $r13=var805, $r14=var1702}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r1 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTagName(java.lang.Class)>(r0);	$z0 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("y");	if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("s");	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	$i1 = $i0 - 1;	$r11 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ies");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 2