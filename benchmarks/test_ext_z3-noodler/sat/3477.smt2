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

(declare-sort var2532 0)
(declare-sort var1263 0)
(declare-sort var2900 0)
(declare-sort var2983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2900) void)
(declare-fun cast-from-var2532-to-var2900 (var2532) var2900)
(declare-fun cidr/519629603 (var2532) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun var2983_getByName/-494382334 (String) var2983)
(declare-fun inetAddress/519629603 (var2532) var2983)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun prefixLength/519629603 (var2532) Int)
(declare-fun calculate/1105244182 (var2532) void)
(declare-const null-var2532 var2532)
(declare-const null-String String)
(declare-const var2465 var2532) ; Statement: r0 := @this: org.apache.dubbo.common.utils.CIDRUtils 
(assert (not (= var2465 null-var2532)))
(declare-const var1600 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1600 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2532-to-var2900 var2465))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2465!1 var2532)
(declare-const var2465!2 var2532)
(assert (not (= var2465!2 null-var2532)))
(assert (= (cidr/519629603 var2465!2) var1600)) ; Statement: r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> = r1 
(define-const var1118 String (cidr/519629603 var2465!2)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> 
(assert true)
(define-const var2250 Bool (contains/1009244746 var1118 (cast-from-String-to-String "/"))) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean contains(java.lang.CharSequence)>("/") 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.IllegalArgumentException 
(assert (not (= (ite var2250 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3044 String (cidr/519629603 var2465!2)) ; Statement: $r4 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> 
(assert true)
(define-const var865 Int (indexOf/-1209756239 var3044 "/")) ; Statement: i0 = virtualinvoke $r4.<java.lang.String: int indexOf(java.lang.String)>("/") 
(define-const var1639 String (cidr/519629603 var2465!2)) ; Statement: $r5 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> 
(assert (and true (and (>= 0 0) (>= (str.len var1639) var865) (>= var865 0))))
(define-const var3431 String (substring/-1240304868 var1639 0 var865)) ; Statement: r6 = virtualinvoke $r5.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(define-const var2717 String (cidr/519629603 var2465!2)) ; Statement: $r7 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> 
(define-const var259 Int (+ var865 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var259 0) (>= (str.len var2717) var259))))
(define-const var1835 String (substring/850833817 var2717 var259)) ; Statement: r8 = virtualinvoke $r7.<java.lang.String: java.lang.String substring(int)>($i1) 
(define-const var1758 var2983 (var2983_getByName/-494382334 var3431)) ; Statement: $r9 = staticinvoke <java.net.InetAddress: java.net.InetAddress getByName(java.lang.String)>(r6) 
(declare-const var2465!3 var2532)
(assert (not (= var2465!3 null-var2532)))
(assert (= (inetAddress/519629603 var2465!3) var1758)) ; Statement: r0.<org.apache.dubbo.common.utils.CIDRUtils: java.net.InetAddress inetAddress> = $r9 
(define-const var1385 Int (Int_parseInt/1370970945 var1835)) ; Statement: $i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r8) 
(declare-const var2465!4 var2532)
(assert (not (= var2465!4 null-var2532)))
(assert (= (prefixLength/519629603 var2465!4) var1385)) ; Statement: r0.<org.apache.dubbo.common.utils.CIDRUtils: int prefixLength> = $i2 
(assert true)
;(assert (calculate/1105244182 var2465!4)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.utils.CIDRUtils: void calculate()>() 

(declare-const var2465!5 var2532)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2532-to-var2900=([org.apache.dubbo.common.utils.CIDRUtils], java.lang.Object), cidr/519629603=([org.apache.dubbo.common.utils.CIDRUtils], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), indexOf/-1209756239=([java.lang.String, java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), var2983_getByName/-494382334=([java.lang.String], java.net.InetAddress), inetAddress/519629603=([org.apache.dubbo.common.utils.CIDRUtils], java.net.InetAddress), Int_parseInt/1370970945=([java.lang.String], int), prefixLength/519629603=([org.apache.dubbo.common.utils.CIDRUtils], int), calculate/1105244182=([org.apache.dubbo.common.utils.CIDRUtils], void)}
; {var2532=org.apache.dubbo.common.utils.CIDRUtils, var2465=r0, var1600=r1, var1263=null_type, var2900=java.lang.Object, var1118=$r2, var2250=$z0, var3044=$r4, var865=i0, var1639=$r5, var3431=r6, var2717=$r7, var259=$i1, var1835=r8, var2983=java.net.InetAddress, var1758=$r9, var1385=$i2}
; {org.apache.dubbo.common.utils.CIDRUtils=var2532, r0=var2465, r1=var1600, null_type=var1263, java.lang.Object=var2900, $r2=var1118, $z0=var2250, $r4=var3044, i0=var865, $r5=var1639, r6=var3431, $r7=var2717, $i1=var259, r8=var1835, java.net.InetAddress=var2983, $r9=var1758, $i2=var1385}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.CIDRUtils;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> = r1;	$r2 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean contains(java.lang.CharSequence)>("/");	if $z0 == 0 goto $r3 = new java.lang.IllegalArgumentException;	$r4 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr>;	i0 = virtualinvoke $r4.<java.lang.String: int indexOf(java.lang.String)>("/");	$r5 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr>;	r6 = virtualinvoke $r5.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r7 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr>;	$i1 = i0 + 1;	r8 = virtualinvoke $r7.<java.lang.String: java.lang.String substring(int)>($i1);	$r9 = staticinvoke <java.net.InetAddress: java.net.InetAddress getByName(java.lang.String)>(r6);	r0.<org.apache.dubbo.common.utils.CIDRUtils: java.net.InetAddress inetAddress> = $r9;	$i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r8);	r0.<org.apache.dubbo.common.utils.CIDRUtils: int prefixLength> = $i2;	specialinvoke r0.<org.apache.dubbo.common.utils.CIDRUtils: void calculate()>();	goto [?= return];	return
;block_num 3