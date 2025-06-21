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

(declare-sort var1336 0)
(declare-sort var2635 0)
(declare-sort var746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var2635_tokenize/-290051344 (String (Array Int Int)) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var746-init () var746)
(declare-fun <init>/-1053635008 (var746 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2943 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2943 null-String)))
(define-const var3627 (Array Int Int) arr-Int-init) ; Statement: $r1 = newarray (char)[2] 
(declare-const var3627!1 (Array Int Int))
(assert (not (= var3627!1 null-__Array__Int__Int__)))
(assert (= (select var3627!1 0) 45)) ; Statement: $r1[0] = 45 
(declare-const var3627!2 (Array Int Int))
(assert (not (= var3627!2 null-__Array__Int__Int__)))
(assert (= (select var3627!2 1) 95)) ; Statement: $r1[1] = 95 
(define-const var640 (Array Int String) (var2635_tokenize/-290051344 var2943 var3627!2)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1) 
(define-const var604 Int (getLength-Arr-String-1 var640)) ; Statement: $i0 = lengthof r2 
 ; Statement: lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; } 
(assert (and (not (= var604 3)) (and (not (= var604 2)) true))) ; Intersect: Negate: Cond: $i0 == 3   and Intersect: Negate: Cond: $i0 == 2   and Non Conditional  
(define-const var798 var746 var746-init) ; Statement: $r10 = new java.util.Locale 
(define-const var3557 String (select var640 0)) ; Statement: $r11 = r2[0] 
(assert true)
;(assert (<init>/-1053635008 var798 var3557)) ; Statement: specialinvoke $r10.<java.util.Locale: void <init>(java.lang.String)>($r11) 

(declare-const var798!1 var746)
(declare-const var3557!1 String)
 ; Statement: return $r10 
(check-sat)
; {arr-Int-init=([], char[]), var2635_tokenize/-290051344=([java.lang.String, char[]], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), var746-init=([], java.util.Locale), <init>/-1053635008=([java.util.Locale, java.lang.String], void)}
; {var2943=r0, var1336=null_type, var3627=$r1, var2635=org.apache.dubbo.common.utils.StringUtils, var640=r2, var604=$i0, var746=java.util.Locale, var798=$r10, var3557=$r11}
; {r0=var2943, null_type=var1336, $r1=var3627, org.apache.dubbo.common.utils.StringUtils=var2635, r2=var640, $i0=var604, java.util.Locale=var746, $r10=var798, $r11=var3557}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = newarray (char)[2];	$r1[0] = 45;	$r1[1] = 95;	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1);	$i0 = lengthof r2;	lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; };	$r10 = new java.util.Locale;	$r11 = r2[0];	specialinvoke $r10.<java.util.Locale: void <init>(java.lang.String)>($r11);	return $r10
;block_num 2