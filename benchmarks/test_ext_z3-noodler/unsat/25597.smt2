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

(declare-sort var2638 0)
(declare-sort var985 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2638 var2638)
(declare-const null-String String)
(declare-const var3947 var2638) ; Statement: r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var3947 null-var2638)))
(declare-const var3267 String) ; Statement: r11 := @parameter0: java.lang.String 
(assert (not (= var3267 null-String)))
(declare-const var1234 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1234 null-String)))
(declare-const var3689 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3689 null-String)))
 ; Statement: if r11 != null goto (branch) 
(assert (not (not (= var3267 null-String)))) ; Negate: Cond: r11 != null  
(define-const var3267!1 String var1234) ; Statement: r11 = r0 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r1 != null goto $r2 = new java.lang.StringBuilder 
(assert (not (= var3689 null-String))) ; Cond: r1 != null 
(define-const var2408 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2408)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2408!1 String)
(assert (= var2408!1 ""))
(assert true)
(define-const var2573 String (append/672562846 var2408!1 var3267!1)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11) 
(declare-const var2408!2 String)
(assert (= var2408!2 (str.++ var2408!1 var3267!1)))
(assert true)
(define-const var1419 String (append/-1166366385 var2573 126)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(126) 
(declare-const var2573!1 String)
(assert (str.prefixof var2573 var2573!1))
(assert true)
(define-const var857 String (append/672562846 var1419 var3689)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1419!1 String)
(assert (= var1419!1 (str.++ var1419 var3689)))
(assert true)
(define-const var3152 String (toString/-2075883882 var857)) ; Statement: $r12 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2638=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var3947=r10, var3267=r11, var985=null_type, var1234=r0, var3689=r1, var2408=$r2, var2573=$r3, var1419=$r4, var857=$r5, var3152=$r12}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var2638, r10=var3947, r11=var3267, null_type=var985, r0=var1234, r1=var3689, $r2=var2408, $r3=var2573, $r4=var1419, $r5=var857, $r12=var3152}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r11 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	if r11 != null goto (branch);	r11 = r0;	goto [?= (branch)];	if r1 != null goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(126);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r12 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 5